within SnowBreathing.Components;

model StreamTestVolumeCO2
  
  parameter Real v_start = 1;
  parameter Real vCO2_start = 0;
  Real V(start = v_start);
  Real VCO2(start = vCO2_start);
  Real CO2;
  replaceable Connectors.FluxConcCO2B fluxConcB annotation(
    Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  CO2 = VCO2 / V;
  der(V) = fluxConcB.q;
//der(Vs) = fluxConcB1.q*fluxConcB1.C;  //ven
  der(VCO2) = fluxConcB.q * actualStream(fluxConcB.CO2);
//ven
  CO2 = fluxConcB.CO2;
  annotation(
    Icon(graphics = {Rectangle(origin = {14, -6}, lineThickness = 2, extent = {{-70, 84}, {70, -84}}), Rectangle(origin = {15, -19}, fillColor = {146, 237, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-71, 67}, {69, -69}})}));
end StreamTestVolumeCO2;