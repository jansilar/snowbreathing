within SnowBreathing.Components;

model CO2Source
  replaceable Connectors.FluxConcCO2 fluxConc annotation(
    Placement(visible = true, transformation(origin = {94, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {94, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput CO2Input annotation(
    Placement(visible = true, transformation(origin = {-86, 86}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-78, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput qInput annotation(
    Placement(visible = true, transformation(origin = {-78, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-78, -72}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  fluxConc.CO2 = CO2Input;
  fluxConc.q = qInput;

annotation(
    Icon(graphics = {Line(origin = {-3, 0}, points = {{-91, 0}, {91, 0}}, color = {0, 170, 255}, thickness = 4, arrow = {Arrow.None, Arrow.Open}, arrowSize = 36), Rectangle(origin = {-1, -1}, extent = {{101, 101}, {-99, -99}})}, coordinateSystem(initialScale = 0.1)));
end CO2Source;