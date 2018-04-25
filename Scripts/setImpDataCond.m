function [diNew, difNew] = setImpDataCond(di, caseID, x, data, setImpData, msg)
    if (setImpData)
        caseID
        di1 = di.(caseID);
        plot(x,data(:,di1.varI));
        fprintf(['- ' msg '\n']);
        pause();
        diNew = readDataInfo(di.baseName);
        %diNew  = updateDataInfo(di)
        difNew = diNew.(caseID);
    else
        diNew = di;
        difNew = di.(caseID);
    end

end