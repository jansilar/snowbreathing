within SnowBreathing.Components;

model PumpConstCO2
  extends SnowBreathing.Components.PumpBaseCO2;
  parameter Real q(unit = "m3/s") = 1;
equation
  fluxConcA.q = q;
end PumpConstCO2;
