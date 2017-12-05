within SnowBreathing.Components;

model DifussionSphereCO2
    parameter Boolean useCO2Solubility = false;
    Real solubilityCoeff(unit = "1") = if useCO2Solubility then (1 + MmCO2 * kH * P *  wc / rho_CO2) else 1;
    //Snow
    constant Real pi = Modelica.Constants.pi;
    DomainLineSegment1D omega(L = R_out, N = 100, x0 = R_in) "in 1D, left is boundary of the central cavity of diameter x0, x coordinate is actually r";
    Real q "volume flow rate";
    Boolean exhale;
    field Real CO2(domain = omega, unit = "m3/m3") "CO2 concentration";
    field Real va_S(domain = omega, unit = "m/s") "velocity of advection";
    parameter Real D = 0.00003 "coefficient of diffusion in snow [m2/s]";
    parameter Real CO2_out = 0 "CO2 concentration out of the sphere";
    parameter Real CO2_init = 0 "initial CO2 concentartion";
    parameter Real R_out = 0.5, R_in = 0.1;
    
        parameter Real rho_CO2(unit = "kg/m3") = 1.977 "kg/m3 (gas at 1 atm and 0 °C)";
    parameter Real rho_air(unit = "kg/m3") = 1.2922 "kg/m3 (gas at 1 atm and 0 °C)";
    parameter Real kH(unit = "mol/kg*Pa") = 0.034 * 1e-5 "mol/kg*Pa (at 25°C) TODO: get value for 0°C!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
    parameter Real wc(unit = "kg/m3") = 10 "kg/m^3 water content in snow";
    parameter Real P(unit = "Pa") = 100000 "Pa";
    parameter Real MmCO2(unit = "kg/mol") = 44.0095 * 1.0e-3 "kg/mol CO2 molar mass";
    
    // DEBUG COMPUTATIONS
//    field Real PCO2(domain = omega, unit = "Pa") "Pa CO2 partial pressure";
//    field Real CO2Snow(domain = omega, unit = "kg/m3") "kg/m3 mass of dissoved CO2 per m3 of snow";
//    field Real cCO2H2O(domain = omega, unit = "mol/kg") "mol/kg molar concentration of CO2 in pure water";
    // / DEBUG
    
    replaceable Connectors.FluxConcCO2B fluxConcB annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  initial equation
    CO2 = CO2_init indomain omega "CO2 concentration initially 0";
  equation
// DEBUG  
//    PCO2 = P * CO2 indomain omega;
//    cCO2H2O = kH * PCO2 indomain omega "Henrys law, concentration in mol/kg";
//    CO2Snow = MmCO2 * cCO2H2O * wc indomain omega;
      
      der(CO2)*solubilityCoeff + (q / (4 * pi * omega.x ^ 2) - 2 * D / omega.x) * pder(CO2, x) - D * pder(CO2, x, x) = 0 indomain omega "the advection-diffusion equation with CO2 solubility";
    
    q = fluxConcB.q;
    exhale = q > 0;
//CavityCO2-snow
    CO2 = if exhale then inStream(fluxConcB.CO2) else extrapolateField(CO2) indomain omega.left "left BC duringexhalation, extrapolation during inhalation";
    fluxConcB.CO2 = CO2 indomain omega.left;
//Snow
    va_S = q / (4 * pi * omega.x ^ 2) indomain omega "velocity of advection";
    CO2 = if exhale then extrapolateField(CO2) else CO2_out indomain omega.right "right/outer BC or extrapolation";
    annotation(
      experiment(StartTime = 0, StopTime = 300, Tolerance = 1e-6, Interval = 0.02),
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Ellipse(origin = {2, -12}, lineColor = {129, 207, 255}, fillColor = {129, 207, 255}, fillPattern = FillPattern.Sphere, extent = {{-102, 112}, {98, -88}}, endAngle = 360)}));
end DifussionSphereCO2;
