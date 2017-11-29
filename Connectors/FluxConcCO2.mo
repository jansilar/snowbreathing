within SnowBreathing.Connectors;

connector FluxConcCO2
  flow Real q(unit = "m3/s") "Volume flow rate from the connection point into the component";
  stream Real CO2(unit = "1") "CO2 volume concentration";
  annotation(
    Icon(graphics = {Rectangle(origin = {1, -1}, lineColor = {0, 12, 255}, fillColor = {0, 12, 255}, fillPattern = FillPattern.Solid, extent = {{-101, 101}, {99, -99}})}));
end FluxConcCO2;