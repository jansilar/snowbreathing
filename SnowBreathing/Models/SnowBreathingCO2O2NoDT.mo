within SnowBreathing.Models;

model SnowBreathingCO2O2NoDT
    constant Real pi = Modelica.Constants.pi;
    parameter Real V_cavity = 0.001;
    SnowBreathing.Components.LungsCO2O2 lungs annotation(
      Placement(visible = true, transformation(origin = {-60, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.CavityCO2O2 cavity(V = V_cavity) annotation(
      Placement(visible = true, transformation(origin = {-4, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.DifussionSphereCO2O2 difussionSphere(R_in = (3 / 4 * V_cavity / pi) ^ (1 / 3)) annotation(
      Placement(visible = true, transformation(origin = {54, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
    connect(cavity.fluxConcB, difussionSphere.fluxConcB) annotation(
      Line(points = {{4, 2}, {54, 2}, {54, 4}, {54, 4}}, color = {170, 170, 0}));
    connect(lungs.fluxConcA, cavity.fluxConcA) annotation(
      Line(points = {{-60, -4}, {-58, -4}, {-58, 2}, {-8, 2}, {-8, 2}}, color = {0, 12, 255}));
end SnowBreathingCO2O2NoDT;


