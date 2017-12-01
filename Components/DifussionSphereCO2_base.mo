within SnowBreathing.Components;

model DifussionSphereCO2_base
    //Snow
    constant Real pi = Modelica.Constants.pi;
    DomainLineSegment1D omega(L = R_out, N = 4, x0 = R_in) "in 1D, left is boundary of the central cavity of diameter x0, x coordinate is actually r";
    Real q "volume flow rate";
    Boolean exhale;
    field Real CO2(domain = omega, unit = "m3/m3") "CO2 concentration";
    field Real va_S(domain = omega, unit = "m3/m3") "velocity of advection";
    parameter Real D = 0.00003 "coefficient of diffusion in snow [m2/s]";
    parameter Real CO2_out = 0 "CO2 concentration out of the sphere";
    parameter Real CO2_init = 0 "initial CO2 concentartion";
    parameter Real R_out = 0.5, R_in = 0.1;
    replaceable Connectors.FluxConcCO2B fluxConcB annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  initial equation
    CO2 = CO2_init indomain omega "CO2 concentration initially 0";
  equation
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
end DifussionSphereCO2_base;
