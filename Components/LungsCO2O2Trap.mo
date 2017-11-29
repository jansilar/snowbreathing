within SnowBreathing.Components;

model LungsCO2O2Trap
    extends SnowBreathing.Components.LungsCO2Trap(redeclare Connectors.FluxConcCO2O2A fluxConcA);
    Real VO2(start = (V_max_L + V_0_L) * 0.2 - VCO2_prod * T_L / 2, fixed = true) "volume of C02 in lungs [m3]";
    Real O2 "O2 concentration in lungs";
equation
    der(VO2) = q * actualStream(fluxConcA.O2) - VCO2_prod "CO2 volume given by breathing and metabolic consumption";
    O2 = VO2 / V;
    fluxConcA.O2 = O2;
end LungsCO2O2Trap;