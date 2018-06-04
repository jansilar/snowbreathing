within SnowBreathing.Models;

model c004_8S2000_snow
  SnowBreathing.Components.ConeCompGrad coneCompGrad( D_CO2 = 1e-2, D_O2 = 3e-4,caseID = "c004-8S2000", useCO2Solubility = false) annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.ExperimentalData data(caseID = "c004-8S2000") annotation(
    Placement(visible = true, transformation(origin = {-54, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.VirtualCavity virtualCavity annotation(
    Placement(visible = true, transformation(origin = {-32, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(coneCompGrad.fluxConcB, virtualCavity.fluxConcCO2O2) annotation(
    Line(points = {{10, 0}, {-10, 0}, {-10, 40}, {-24, 40}, {-24, 40}}, color = {170, 170, 0}));
  connect(data.CO2Out, virtualCavity.CO2In) annotation(
    Line(points = {{-50, 4}, {-50, 4}, {-50, 16}, {-40, 16}, {-40, 32}, {-40, 32}}, color = {0, 0, 127}));
  connect(data.O2Out, virtualCavity.O2In) annotation(
    Line(points = {{-48, 4}, {-48, 14}, {-34, 14}, {-34, 32}, {-36, 32}}, color = {0, 0, 127}));
  connect(data.qOut, virtualCavity.qIn) annotation(
    Line(points = {{-46, 4}, {-30, 4}, {-30, 32}, {-30, 32}}, color = {0, 0, 127}));
  connect(data.fluxConcCO2O2, coneCompGrad.fluxConcB) annotation(
    Line(points = {{-46, -6}, {-18, -6}, {-18, 0}, {10, 0}}, color = {0, 12, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 686, Tolerance = 1e-06, Interval = 0.04));
end c004_8S2000_snow;