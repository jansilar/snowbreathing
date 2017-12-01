within SnowBreathing.Components;

model DifussionSphereCO2O2Sol
    extends SnowBreathing.Components.DifussionSphereCO2O2_base;
    parameter Real rho_CO2(unit = "kg/m3") = 1.977 "kg/m3 (gas at 1 atm and 0 °C)";
    parameter Real rho_air(unit = "kg/m3") = 1.2922 "kg/m3 (gas at 1 atm and 0 °C)";
    parameter Real kH(unit = "mol/kg*Pa") = 0.034 * 1e-5 "mol/kg*Pa (at 25°C) TODO: get value for 0°C!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
    parameter Real wc(unit = "kg/m3") = 10 "kg/m^3 water content in snow";
    parameter Real P(unit = "Pa") = 100000 "Pa";
    parameter Real MmCO2(unit = "kg/mol") = 44.0095 * 1.0e-3 "kg/mol CO2 molar mass";
    field Real PCO2(domain = omega, unit = "Pa") "Pa CO2 partial pressure";
    field Real CO2Snow(domain = omega, unit = "kg/m3") "kg/m3 mass of dissoved CO2 per m3 of snow";
    field Real cCO2H2O(domain = omega, unit = "mol/kg") "mol/kg molar concentration of CO2 in pure water";
equation
//Snow
    PCO2 = P * CO2 indomain omega;
    cCO2H2O = kH * PCO2 indomain omega "Henrys law, concentration in mol/kg";
    CO2Snow = MmCO2 * cCO2H2O * wc indomain omega;
  //  der(CO2) + der(CO2Snow) / rho_CO2 + (q / (4 * pi * omega.x ^ 2) - 2 * D / omega.x) * pder(CO2, x) - D * pder(CO2, x, x) = 0 indomain omega "the advection-diffusion equation";
    //above is equivalently to, bacause of numerical problems:
    der(CO2)*(1 + MmCO2 * kH * P *  wc / rho_CO2) + (q / (4 * pi * omega.x ^ 2) - 2 * D / omega.x) * pder(CO2, x) - D * pder(CO2, x, x) = 0 indomain omega "the advection-diffusion equation";
end DifussionSphereCO2O2Sol;
