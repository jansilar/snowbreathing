within SnowBreathing.Models;

model c004_11m2000_snow
  SnowBreathing.Components.ExperimentalData experimentalData1(caseID = "c004-11m2000")  annotation(
    Placement(visible = true, transformation(origin = {-58, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.ConeCompGrad coneCompGrad1(D_CO2 = 4.48799322137e-4, D_O2 = 4.48799322137e-4, caseID = "c004-11m2000", gamma = 0.0205209563215, solubilityModel = 2)  annotation(
    Placement(visible = true, transformation(origin = {10, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.VirtualCavity virtualCavity1 annotation(
    Placement(visible = true, transformation(origin = {-42, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(virtualCavity1.fluxConcCO2O2, coneCompGrad1.fluxConcB) annotation(
    Line(points = {{-34, 66}, {6, 66}, {6, -12}, {10, -12}, {10, -14}}, color = {0, 12, 255}));
  connect(experimentalData1.qOut, virtualCavity1.qIn) annotation(
    Line(points = {{-50, -2}, {-40, -2}, {-40, 58}, {-40, 58}}, color = {0, 0, 127}));
  connect(virtualCavity1.O2In, experimentalData1.O2Out) annotation(
    Line(points = {{-46, 58}, {-46, 58}, {-46, 38}, {-52, 38}, {-52, -2}, {-52, -2}}, color = {0, 0, 127}));
  connect(experimentalData1.CO2Out, virtualCavity1.CO2In) annotation(
    Line(points = {{-54, -2}, {-64, -2}, {-64, 58}, {-50, 58}}, color = {0, 0, 127}));
  connect(experimentalData1.fluxConcCO2O2, coneCompGrad1.fluxConcB) annotation(
    Line(points = {{-50, -12}, {10, -12}, {10, -14}, {10, -14}}, color = {0, 12, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 580, Tolerance = 1e-06, Interval = 0.04));
end c004_11m2000_snow;