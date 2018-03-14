within SnowBreathing.Components;

model PumpConstCO2O2
  extends SnowBreathing.Components.PumpConstCO2(redeclare Connectors.FluxConcCO2O2A fluxConcA, redeclare Connectors.FluxConcCO2O2B fluxConcB);
equation
  fluxConcA.O2 = inStream(fluxConcB.O2);
  inStream(fluxConcA.O2) = fluxConcB.O2;

end PumpConstCO2O2;