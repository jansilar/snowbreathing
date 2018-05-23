import os
import sys
import time
from scipy.optimize import minimize

from OMPython import ModelicaSystem

class ModelicaModel:
    def __init__(self, file, name):
        self.file = file
        self.name = name
        self.mod = ModelicaSystem(file, name)
        print self.mod.getParameters()
        print self.mod
        #TODO: osetrit pripad, kdy otevreni neprojde

    def set_stop_time(self, stop_time):
        self.mod.setSimulationOptions(stopTime=stop_time)

    def set_parameters(self, param_dict):
        self.mod.setParameters(**param_dict)

    def simulate(self):
        self.mod.simulate()

    def set_param_and_simulate(self, paramDict):
        self.set_parameters(paramDict)
        self.simulate()

    def get_var_final(self, var):
        return self.mod.getContinuous(var)


class Optimization:
    def __init__(self, model, objective_variable, parameters_init_dict, stop_time):
        self.model = model
        self.objective_variable = objective_variable
        self.parameters = list(parameters_init_dict.keys())
        self.init_values = list(parameters_init_dict.values())
        self.model.set_stop_time(stop_time)
        self.neval = 0

    def objective_fun(self, parameter_values):
        param_dict = dict(zip(self.parameters, parameter_values))
        self.model.set_param_and_simulate(param_dict)
        self.neval += 1
        print "Evaluation number " + str(self.neval) + "\n"
        print "Parameters " + str(param_dict) + "\n"

        objective_val =  self.model.get_var_final(self.objective_variable)

        print "objective value: " + str(objective_val) + "\n"
        return objective_val

    def optimize(self):
        return minimize(self.objective_fun, self.init_values, method='Nelder-Mead', tol=1e-6)


def save_and_print_results(file_name, model_name, parameter_names, objective_variable, results):
    p_val = results["x"]
    file_name_txt = "./Results/" + os.path.splitext(os.path.basename(file_name))[0] + "_" + model_name + ".txt"
    with open(file_name_txt, "a") as f:
        f.write("Time:\t" + str(time.ctime()) + "\n")
        f.write("Model file:\t" + file_name + "\n")
        f.write("Model:\t" + model_name + "\n")
        f.write("Objective:\t" + objective_variable + "\n")
        f.write("Results:\n" + str(results) + "\n")
        print("Results:\n" + str(results) + "\n")
        for i in range(len(p_val)):
            f.write(parameter_names[i] + " = " + str(p_val[i]) + "\n")
            print(parameter_names[i] + " = " + str(p_val[i]) + "\n")
        f.write("\n------------------------------------------------------------\n\n\n")
    f.close()


def complete_identification(model_file, model_name, objective_variable, parameters_init_dict, stop_time):
    model_file_abs = os.path.abspath(model_file)
    os.chdir("./WorkingDir")
    model = ModelicaModel(model_file_abs, model_name)
    optim = Optimization(model, objective_variable, parameters_init_dict, stop_time)
    results = optim.optimize()
    os.chdir("../")
    save_and_print_results(model_file, model_name, parameters_init_dict.keys(), objective_variable, results)
    return results["x"]



#dumping_model_identification()

#print complete_identification("../Dumping.mo", "Dumping", "y", {"k": 1}, 10)

#print complete_identification("../SnowBreathing/package.mo", "SnowBreathing.Models.c013_12s2000_snow", "coneCompGrad.RMSCO2", {"coneCompGrad.D_CO2": 3.0e-4}, 800)
print complete_identification("advection.mo", "advection", "uu", {"c": 0.7}, 0.5)