within SnowBreathing.Models;

model SolTest
  SnowBreathing.Components.Cone cone1(D_CO2 = 1e-3, solubilityModel = 2)  annotation(
    Placement(visible = true, transformation(origin = {24, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constCO2(k = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {-86, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.CO2O2Source cO2O2Source1 annotation(
    Placement(visible = true, transformation(origin = {-18, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constO2(k = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-86, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.VirtualCavity virtualCavity1 annotation(
    Placement(visible = true, transformation(origin = {-32, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse pulse1(amplitude = -0.004, nperiod = 1, offset = 0.002, period = 2)  annotation(
    Placement(visible = true, transformation(origin = {-86, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(pulse1.y, virtualCavity1.qIn) annotation(
    Line(points = {{-74, -18}, {-36, -18}, {-36, 62}, {-30, 62}, {-30, 82}, {-30, 82}}, color = {0, 0, 127}));
  connect(pulse1.y, cO2O2Source1.qInput) annotation(
    Line(points = {{-74, -18}, {-36, -18}, {-36, 44}, {-26, 44}, {-26, 42}}, color = {0, 0, 127}));
  connect(cone1.fluxConcB, virtualCavity1.fluxConcCO2O2) annotation(
    Line(points = {{24, 52}, {2, 52}, {2, 90}, {-24, 90}, {-24, 90}}, color = {170, 170, 0}));
  connect(constO2.y, cO2O2Source1.O2Input) annotation(
    Line(points = {{-75, 46}, {-43, 46}, {-43, 54}, {-27, 54}}, color = {0, 0, 127}));
  connect(virtualCavity1.O2In, constO2.y) annotation(
    Line(points = {{-36, 82}, {-36, 65}, {-42, 65}, {-42, 46}, {-74, 46}}, color = {0, 0, 127}));
  connect(virtualCavity1.CO2In, constCO2.y) annotation(
    Line(points = {{-40, 82}, {-58, 82}, {-58, 76}, {-74, 76}}, color = {0, 0, 127}));
  connect(constCO2.y, cO2O2Source1.CO2Input) annotation(
    Line(points = {{-75, 76}, {-50.5, 76}, {-50.5, 58}, {-26, 58}}, color = {0, 0, 127}));
  connect(cO2O2Source1.fluxConc, cone1.fluxConcB) annotation(
    Line(points = {{-8.6, 50}, {7.4, 50}, {7.4, 50}, {23.4, 50}, {23.4, 52}, {23.4, 52}, {23.4, 52}, {23.4, 52}}, color = {0, 12, 255}));

annotation(
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-06, Interval = 0.001));end SolTest;