within SnowBreathing.Components;

model StreamTestVolumeCO2O2
  extends SnowBreathing.Components.StreamTestVolumeCO2(redeclare Connectors.FluxConcCO2O2B fluxConcB);
  Real O2;
  parameter Real VO2_start = 0.2;
  Real VO2(start = VO2_start);
equation
  O2 = VO2/V;
  der(VO2) = fluxConcB.q * actualStream(fluxConcB.O2);
  O2 = fluxConcB.O2;
end StreamTestVolumeCO2O2;