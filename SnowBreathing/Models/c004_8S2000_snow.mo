within SnowBreathing.Models;

model c004_8S2000_snow
  SnowBreathing.Components.ConeCompGrad coneCompGrad( D_CO2 = 1e-2, D_O2 = 3e-4,caseID = "c004-8S2000", useCO2Solubility = false) annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.ExperimentalData data(caseID = "c004-8S2000") annotation(
    Placement(visible = true, transformation(origin = {-54, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(data.fluxConcCO2O2, coneCompGrad.fluxConcB) annotation(
    Line(points = {{-46, -6}, {-18, -6}, {-18, 0}, {10, 0}}, color = {0, 12, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 686, Tolerance = 1e-06, Interval = 0.04));
end c004_8S2000_snow;