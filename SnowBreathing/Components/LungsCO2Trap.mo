within SnowBreathing.Components;

 model LungsCO2Trap
    replaceable Connectors.FluxConcCO2A fluxConcA annotation(
      Placement(visible = true, transformation(origin = {6, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {6, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Boolean exhale;
    Real q "flux into lungs";
    constant Real pi = Modelica.Constants.pi;
    //Lungs:
    parameter Real T_L (unit = "s")= 4 "breathing period [s]";
    parameter Real V_max_L (unit = "m3")= 0.0048 "maximal useful lungs volume [m3]";
    parameter Real V_0_L (unit = "m3")= 0.001 "residual capacity [m3]";
    parameter Real q_max (unit = "m3/s")= V_max_L / (T_L / 2 - risingT) "absolute value of air flux [m3/s]";
    parameter Real VCO2_prod(unit = "m3/s") = 0.0003 * 0.8 / 60 "volume of CO2 produced per second [m3/s]";
    Real V(start = V_max_L + V_0_L, fixed = true, unit = "m3") "current lungs volume [m3]";
    Real VCO2(start = VCO2_prod * T_L / 2, fixed = true, unit = "m3") "volume of C02 in lungs [m3]";
    Real CO2(unit = "m3/m3") "CO2 concentration in lungs";
    Modelica.Blocks.Sources.Trapezoid breathTrapezoid(amplitude = q_max, falling = risingT, period = T_L / 2, rising = risingT, width = T_L / 2 - 2 * risingT) annotation(
      Placement(visible = true, transformation(origin = {-64, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real risingT(unit = "s") = 0.5 "rising and falling time of breath [s]";
  equation
//Lungs
    exhale = sin(2 * pi * time / T_L) > 0;
    q = if exhale then -breathTrapezoid.y else breathTrapezoid.y;
    der(V) = q;
    der(VCO2) = q * actualStream(fluxConcA.CO2) + VCO2_prod "CO2 volume given by breathing and metabolic production";
    CO2 = VCO2 / V;
//Lungs-cavity interface
    fluxConcA.q = q;
    fluxConcA.CO2 = CO2;
//inStream(fluxConcA.c) =
    annotation(
      Icon(graphics = {Line(origin = {-30.601, -0.699606}, points = {{7, 54.5741}, {-7, 48.5741}, {-13, 38.5741}, {-15, 30.5741}, {-19, 12.5741}, {-23, -5.42591}, {-25, -21.4259}, {-25, -43.4259}, {-25, -59.4259}, {-21, -63.4259}, {-15, -63.4259}, {-9, -53.4259}, {-3, -41.4259}, {3, -37.4259}, {17, -27.4259}, {23, -23.4259}, {25, -7.42591}, {25, 16.5741}, {23, 38.5741}, {19, 52.5741}, {15, 54.5741}, {9, 54.5741}}, color = {232, 191, 227}, thickness = 4, smooth = Smooth.Bezier), Line(origin = {38, -11.54}, points = {{-18, 63.5354}, {-7, 60.5354}, {-2, 57.5354}, {6, 47.5354}, {12, 35.5354}, {16, 19.5354}, {22, 1.53541}, {22, -10.4646}, {22, -30.4646}, {18, -46.4646}, {14, -60.4646}, {10, -56.4646}, {0, -48.4646}, {-12, -42.4646}, {-22, -40.4646}, {-14, -26.4646}, {-8, -8.46459}, {-8, 3.53541}, {-14, 13.5354}, {-22, 25.5354}, {-22, 35.5354}, {-20, 55.5354}, {-18, 63.5354}}, color = {232, 191, 227}, thickness = 4, smooth = Smooth.Bezier), Line(origin = {5.20203, 57.1296}, points = {{0, 25}, {0, -25}}, color = {166, 224, 255}, thickness = 8), Line(origin = {19, 24}, points = {{15, -8}, {-13, 8}}, color = {166, 224, 255}, thickness = 6), Line(origin = {-9, 24}, points = {{15, 8}, {-15, -8}}, color = {166, 224, 255}, thickness = 6)}));
  end LungsCO2Trap;

