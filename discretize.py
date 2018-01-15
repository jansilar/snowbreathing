#working directory must be one level higher, than is this file in the repo
import OMPython;
import re;
import os;
import shutil;
import errno;

def omCommand(comm, omc):
    print("Task: " + comm + "\n");
    ret = omc.sendExpression(comm);
    print(omc.sendExpression("getErrorString()"));
    return ret;

def omCommandP(comm, omc):
    print("Task: " + comm + "\n");
    print(omc.sendExpression(comm));
    print(omc.sendExpression("getErrorString()"));

def removeDotsAndBrackets(str):
    dotRe = re.compile('([^ ])([.]|[$])([a-zA-Z])');
    str = dotRe.sub(r'\1_\3', str);
    bracketRe = re.compile('(\[)([0-9]+)(\])');
    str = bracketRe.sub(r'_\2', str);
    return str;

def removeDomainAndRegion(str):
    #domainRe = re.compile('(function DomainLineSegment1D)([.])(end DomainLineSegment1D;)');
    #domainRe = re.compile('(f)([.])(n)');
    #return domainRe.sub('',str,re.DOTALL);
    #print(domainRe.pos(str));
    return str.split("\n", 16)[16];

def removePlusMinus(str):
    pmRe = re.compile('(\+ -)')
    str = pmRe.sub(r'-', str)
    return str

def manageModelName(str,nameUnqual):
    str = str.replace("class SnowBreathing_Components_" + nameUnqual, "within SnowBreathing.Components;\n"
                                                                     +"model " + nameUnqual + "_discretised")
    str = str.replace("end SnowBreathing_Components_" + nameUnqual + ";", "end " + nameUnqual + "_discretised" + ";")
    return str

def removeNonAscii(str):
    return re.sub(r'[^\x00-\x7F]+', ' ', str)

def discretize(omc, nameUnqual, nameQual):
    modelStr = omCommand("instantiateModel(" + nameQual + ")", omc)
    modelStr = removeDotsAndBrackets(modelStr)
    modelStr = removeDomainAndRegion(modelStr)
    modelStr = removePlusMinus(modelStr)
    modelStr = manageModelName(modelStr, nameUnqual)
    #modelStr = removeNonAscii(modelStr)
    print("done!\n");
    return modelStr

def createDiscretizedLib():
    #os.chdir("./..")

    # copy all files:
    dirD = "Discretized";
    dirSB = "SnowBreathing";

    if os.path.exists(dirD):
        shutil.rmtree(dirD);
    os.mkdir(dirD);
    os.mkdir(dirD + "/" + dirSB);
    for d in os.listdir(dirSB):
        if d != ".git":
            src = dirSB + "/" + d;
            dst = dirD + "/" + dirSB + "/" + d;
            if os.path.isdir(src):
                shutil.copytree(src, dst)
            else:
                shutil.copy(src, dst)
#discretize PDEModelica:
    toDiscretize = [
        "DifussionSphereCO2",
        "DifussionSphereCO2O2"
    ]

    omc = OMPython.OMCSessionZMQ();
    #print("omc verze: " + omCommand("getVersion()", omc));
    #omCommandP("setCompilerFlags(\"--grammar=PDEModelica\")", omc);
    omCommandP("setCommandLineOptions(\"--grammar=PDEModelica\")", omc)
    omCommandP("loadModel(Modelica)", omc)
    omCommandP("loadFile(\"" + dirSB + "/package.mo" + "\")", omc)
    pOFile = open(dirD + "/" + dirSB + "/" + "Components/package.order", "a")
    for nameUnqual in toDiscretize:
        fileName = dirD + "/" + dirSB + "/" +"Components/" + nameUnqual + "_discretised.mo"
        nameQual = "SnowBreathing.Components." + nameUnqual
        modelStr = discretize(omc, nameUnqual, nameQual)
        dirname = os.path.dirname(fileName)
        if not os.path.exists(dirname):
            os.makedirs(dirname)
        F = open(fileName,"wt+")
#        F.write(modelStr.encode("utf8"))
        F.write(modelStr)
        F.close()
        shutil.copy("./AuxMo/" + nameUnqual + ".mo", dirD + "/SnowBreathing/Components/" + nameUnqual + ".mo")
        pOFile.write(nameUnqual+"_discretised\n")
    pOFile.close()
createDiscretizedLib();
#print(discretize("./SnowBreathing/package.mo", "SnowBreathing.Components.DifussionSphereCO2"))

#TODO: in discretised files yet manualy
#    - delete the fluxConc_q = 0; equation
#    - add the fluxConc_CO2(O2)In variable
#    - modify the boundary condition to incorporate the ..In var.