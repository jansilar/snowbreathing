within SnowBreathing.Models;

model SolDynamicTest
  SnowBreathing.Components.CO2Source cO2Source1 annotation(
    Placement(visible = true, transformation(origin = {-28, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(amplitude = 0.1, falling = 0.4, nperiod = 1, period = 4, rising = 0.4, width = 3.2)  annotation(
    Placement(visible = true, transformation(origin = {-70, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse pulse1(amplitude = -0.002, nperiod = 1, offset = 0.001, period = 8, width = 50)  annotation(
    Placement(visible = true, transformation(origin = {-78, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.DifussionSphereCO2 difussionSphereCO21(solubilityModel = 2)  annotation(
    Placement(visible = true, transformation(origin = {32, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(cO2Source1.fluxConc, difussionSphereCO21.fluxConcB) annotation(
    Line(points = {{-18, 8}, {32, 8}, {32, 8}, {32, 8}}, color = {0, 12, 255}));
  connect(trapezoid1.y, cO2Source1.CO2Input) annotation(
    Line(points = {{-59, 16}, {-36, 16}}, color = {0, 0, 127}));
  connect(pulse1.y, cO2Source1.qInput) annotation(
    Line(points = {{-66, -16}, {-50, -16}, {-50, 1}, {-36, 1}}, color = {0, 0, 127}));

annotation(
    experiment(StartTime = 0, StopTime = 40, Tolerance = 1e-06, Interval = 0.02));
end SolDynamicTest;