within SnowBreathing.Components;

model TemperatureStepCO2O2
  extends SnowBreathing.Components.TemperatureStepCO2(redeclare Connectors.FluxConcCO2O2A fluxConcA, 
                                                      redeclare Connectors.FluxConcCO2O2B fluxConcB);
equation
  inStream(fluxConcA.O2) = fluxConcB.O2;
  fluxConcA.O2           = inStream(fluxConcB.O2);
end TemperatureStepCO2O2;