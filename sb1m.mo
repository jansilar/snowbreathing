model sb1m
  Boolean exhale;
  Real q "flux from tube outflow";
  constant Real pi = 3.14159;
//Lungs:
  parameter Real T_L = 4 "breathing period [s]";
  parameter Real V_max_L = 0.0048 "maximal lungs volume [m3]";
  parameter Real V_0_L = 0.001 "residual capacity [m3]";
  parameter Real q_abs_L = V_max_L / T_L * 2 "absolute value of air flux [m/s]";
  parameter Real VCO21_L = 0.0003*0.8/60 "volume of CO2 produced per second [m3/s]";
  Real V_L(start = V_max_L + V_0_L, fixed = true) "current lungs volume [m3]";
  Real VCO2_L(start = VCO21_L*T_L/2, fixed = true) "volume of C02 in lungs [m3]";
  Real C_L "concentration in lungs";
//Lungs-cavity
  Real C_LC "concentration on lungs-cavity interface";
//Cavity:
  parameter Real R_C = (V_C*3/4/pi)^(1/3) "cavity radius [m]";
  parameter Real V_C = 0.001 "cavity volume [m3]";
  Real VCO2_C(start = 0, fixed = true) "volume of CO2 in cavity [m3]";
  Real C_C "concentration in cavity]";
//Cavity-snow
  Real C_CS "concentration on cavity-snow interface";
//Snow
  DomainLineSegment1D omega(L = 0.5, N = 100, x0 = R_C) "in 1D, left is boundary of the central cavity of diameter x0, x coordinate is actually r";
  field Real C_S(domain = omega) "concentration";
  field Real va_S(domain = omega) "velocity of advection";
  parameter Real D_S = 0.00003 "coefficient of CO2 diffusion in snow [m2/s]";
  parameter Real                 C_out_S = 0 "CO2 concentration out of the sphere";
initial equation 
  C_S = 0  indomain omega "CO2 concentration initially 0";
equation 
//Lungs
  exhale = sin(2*pi*time/T_L)>0;
  q = if exhale then q_abs_L else -q_abs_L;
  der(V_L) = -q;
  der(VCO2_L) = -q*C_LC + VCO21_L "CO2 volume given by breathing and metabolic production";
  C_L = VCO2_L/V_L;
 
//Lungs-cavity interface
  C_LC = if exhale then C_L else C_C "during exhalation given by concentration in lungs,
                                  during inhalation by concentration in cavity";
//Cavity
  der(VCO2_C) = q*(C_LC - C_CS) "CO2 coming/leaving from lungs and snow";
  C_C = VCO2_C/V_C;
 
//Cavity-snow
  C_S = if exhale then C_CS else extrapolateField(C_S) indomain omega.left "left BC during
                                          exhalation, extrapolation during inhalation";
 C_CS = if exhale then C_C else C_S indomain omega.left;
 
//Snow
  va_S = q / (4 * pi * omega.x ^ 2) indomain omega "velocity of advection";
  der(C_S) + (q / (4 * pi * omega.x ^ 2) - 2 * D_S / omega.x) * pder(C_S, x)
          - D_S * pder(C_S, x, x) = 0 indomain omega  "the advection-diffusion equation";
  C_S = (if exhale then  extrapolateField(C_S)
  else  C_out_S) indomain omega.right  "right BC or extrapolation";
end sb1m;
