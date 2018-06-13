within SnowBreathing.Models;

model c007_08s2000_snow
  SnowBreathing.Components.ConeCompGrad coneCompGrad( D_CO2 = 1e-2, D_O2 = 3e-4,caseID = "c013-12s2000", useCO2Solubility = false) annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.ExperimentalData data(caseID = "c013-12s2000") annotation(
    Placement(visible = true, transformation(origin = {-58, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.VirtualCavity virtualCavity annotation(
    Placement(visible = true, transformation(origin = {-46, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(virtualCavity.fluxConcCO2O2, coneCompGrad.fluxConcB) annotation(
    Line(points = {{-38, 34}, {10, 34}, {10, 0}, {10, 0}}, color = {0, 12, 255}));
  connect(data.qOut, virtualCavity.qIn) annotation(
    Line(points = {{-50, 2}, {-44, 2}, {-44, 26}, {-44, 26}}, color = {0, 0, 127}));
  connect(data.O2Out, virtualCavity.O2In) annotation(
    Line(points = {{-52, 1}, {-52, 13.5}, {-50, 13.5}, {-50, 26}}, color = {0, 0, 127}));
  connect(data.CO2Out, virtualCavity.CO2In) annotation(
    Line(points = {{-54, 1}, {-56, 1}, {-56, 26}, {-54, 26}}, color = {0, 0, 127}));
  connect(data.fluxConcCO2O2, coneCompGrad.fluxConcB) annotation(
    Line(points = {{-50, -8}, {-18, -8}, {-18, 0}, {10, 0}}, color = {0, 12, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 611, Tolerance = 1e-06, Interval = 0.04));
end c007_08s2000_snow;