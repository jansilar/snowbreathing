within SnowBreathing.Components;

model VirtualCavity
  Connectors.FluxConcCO2O2A fluxConcCO2O2 annotation(
    Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput CO2In annotation(
    Placement(visible = true, transformation(origin = {-40, -72}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput O2In annotation(
    Placement(visible = true, transformation(origin = {0, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-32, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput qIn annotation(
    Placement(visible = true, transformation(origin = {10, 8}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {18, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  parameter Real V(unit = "m3") = 0.002;
  Real VCO2(unit = "m3");
  Real VCO2InTotal(unit = "m3", start = 0) "total CO2 volume that came into the cavity";
  Real VO2(unit = "m3");
  Real CO2(unit = "m3/m3");
  Real O2(unit = "m3/m3");
  Real ErrCO2(start = 0, fixed = true);
  Real ErrO2(start = 0, fixed = true);
  Boolean inhale;
equation
  fluxConcCO2O2.q = 0;   //no real air exchange between the cavity and snow
  when qIn > 0 then       //reset on each inspiration start
    reinit(VCO2, V*CO2In);
    reinit(VO2, V*O2In);
  end when;
  inhale = qIn > 1.0e-8;
  der(VCO2) = if inhale then (inStream(fluxConcCO2O2.CO2)-CO2)*qIn else 0;
  der(VO2)  = if inhale then (inStream(fluxConcCO2O2.O2) -O2)*qIn else 0;
  der(VCO2InTotal) = if inhale then inStream(fluxConcCO2O2.CO2)*qIn else 0;
  der(ErrCO2) = if inhale then CO2 - CO2In else 0;
  der(ErrO2)  = if inhale then O2  - O2In  else 0;
  CO2 = VCO2/V;
  O2 = VO2/V;
  //dummy equations:
  fluxConcCO2O2.CO2 = 0;
  fluxConcCO2O2.O2 = 0;
annotation(
    Icon(graphics = {Ellipse(origin = {3, -2}, lineColor = {0, 153, 255}, pattern = LinePattern.Dash, lineThickness = 1, extent = {{-103, 102}, {97, -98}}, endAngle = 360)}),
    experiment(StartTime = 0, StopTime = 686, Tolerance = 1e-06, Interval = 0.04));
end VirtualCavity;