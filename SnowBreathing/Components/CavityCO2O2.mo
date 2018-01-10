within SnowBreathing.Components;

model CavityCO2O2
  extends SnowBreathing.Components.CavityCO2(redeclare Connectors.FluxConcCO2O2A fluxConcA, redeclare Connectors.FluxConcCO2O2B fluxConcB);
  Real VO2(unit = "m3");
  Real O2(start = 0.2, unit = "m3/m3");

equation
  der(VO2) = fluxConcA.q * (actualStream(fluxConcA.O2) - actualStream(fluxConcB.O2));
  O2 = VO2/V;
  fluxConcA.O2 = O2;
  fluxConcB.O2 = O2;
end CavityCO2O2;
