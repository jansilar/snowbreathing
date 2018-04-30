within SnowBreathing.Models;

model c013_12s2000_snow
  SnowBreathing.Components.ConeCompGrad coneCompGrad(useCO2Solubility = true)  annotation(
    Placement(visible = true, transformation(origin = {10, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D1 annotation(
    Placement(visible = true, transformation(origin = {-66, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.ExperimentalData data(caseID = "c013_12s2000")  annotation(
    Placement(visible = true, transformation(origin = {-54, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(data.fluxConcCO2O2, coneCompGrad.fluxConcB) annotation(
    Line(points = {{-46, -6}, {10, -6}}, color = {0, 12, 255}));
end c013_12s2000_snow;