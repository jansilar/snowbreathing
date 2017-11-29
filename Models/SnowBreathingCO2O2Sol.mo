within SnowBreathing.Models;

model SnowBreathingCO2O2Sol
  constant Real pi = Modelica.Constants.pi;
  parameter Real V_cavity = 0.001;
  SnowBreathing.Components.LungsCO2O2 lungs annotation(
    Placement(visible = true, transformation(origin = {-62, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.CavityCO2O2 cavity(V = V_cavity) annotation(
    Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
SnowBreathing.Components.DifussionSphereCO2O2Sol difussionSphereCO2O2Sol1 annotation(
    Placement(visible = true, transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.TemperatureStepCO2O2 temperatureStepCO2O21 annotation(
    Placement(visible = true, transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(cavity.fluxConcB, difussionSphereCO2O2Sol1.fluxConcB) annotation(
    Line(points = {{7, 0}, {48, 0}}, color = {170, 170, 0}));
  connect(temperatureStepCO2O21.fluxConcB, cavity.fluxConcA) annotation(
    Line(points = {{-25, 0}, {-6, 0}}, color = {170, 170, 0}));
  connect(lungs.fluxConcA, temperatureStepCO2O21.fluxConcA) annotation(
    Line(points = {{-61, -11}, {-61, 0}, {-43, 0}}, color = {0, 12, 255}));
annotation(
    experiment(StartTime = 0, StopTime = 602, Tolerance = 1e-6, Interval = 0.001));end SnowBreathingCO2O2Sol;