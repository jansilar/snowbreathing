within SnowBreathing.Components;

model CavityCO2
  parameter Real V(unit = "m3") = 1;
  Real VCO2(unit = "m3");
  Real CO2(start = 0, unit = "m3");
  replaceable Connectors.FluxConcCO2A fluxConcA annotation(
    Placement(visible = true, transformation(origin = {-38, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-38, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable Connectors.FluxConcCO2B fluxConcB annotation(
    Placement(visible = true, transformation(origin = {86, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
    Diagram,
    Icon(graphics = {Ellipse(lineColor = {0, 170, 255}, lineThickness = 2,extent = {{-80, 80}, {80, -80}}, endAngle = 360)}));
equation
  fluxConcA.q + fluxConcB.q = 0;
  der(VCO2) = fluxConcA.q * (actualStream(fluxConcA.CO2) - actualStream(fluxConcB.CO2));
  CO2 = VCO2/V;
  fluxConcA.CO2 = CO2;
  fluxConcB.CO2 = CO2;
end CavityCO2;
