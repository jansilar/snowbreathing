within SnowBreathing.Components;

partial model PumpBaseCO2
  replaceable Connectors.FluxConcCO2A fluxConcA annotation(
    Placement(visible = true, transformation(origin = {-88, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-88, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable Connectors.FluxConcCO2B fluxConcB annotation(
    Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  fluxConcA.q + fluxConcB.q = 0;
  fluxConcA.CO2 = inStream(fluxConcB.CO2);
  inStream(fluxConcA.CO2) = fluxConcB.CO2;
  annotation(
    Icon(graphics = {Line(origin = {-4, 1}, points = {{0, 77}, {0, -77}}, thickness = 2), Line(origin = {24.8, 22.19}, points = {{-26.7991, 39.814}, {9.20092, -20.186}, {17.2009, -20.186}, {23.2009, -24.186}, {27.2009, -32.186}, {25.2009, -40.186}, {23.2009, -40.186}}, thickness = 2), Line(origin = {-29, 8}, points = {{23, 4}, {-19, 4}, {-23, 2}, {-23, -4}, {-23, -4}}, thickness = 2)}));
end PumpBaseCO2;