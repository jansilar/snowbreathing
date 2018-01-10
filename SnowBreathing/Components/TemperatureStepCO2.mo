within SnowBreathing.Components;

model TemperatureStepCO2
  replaceable SnowBreathing.Connectors.FluxConcCO2A fluxConcA annotation(
    Placement(visible = true, transformation(origin = {-94, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable SnowBreathing.Connectors.FluxConcCO2B fluxConcB annotation(
    Placement(visible = true, transformation(origin = {74, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real TA(unit = "K") = 310.15 "temperature A, degK", TB(unit = "K") = 273.15 "temperature B, degK";
equation
  inStream(fluxConcA.CO2) = fluxConcB.CO2;
  fluxConcA.CO2           = inStream(fluxConcB.CO2);
  fluxConcA.q/TA + fluxConcB.q/TB = 0;
annotation(
    Icon(graphics = {Rectangle(origin = {-40, 0}, lineColor = {255, 138, 140}, fillColor = {255, 247, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-40, 80}, {40, -80}}), Rectangle(origin = {30, 0}, lineColor = {0, 0, 255}, fillColor = {196, 222, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{50, 80}, {-30, -80}})}));end TemperatureStepCO2;
