within SnowBreathing.Models;

model SnowBreathingCO2NoDT
    constant Real pi = Modelica.Constants.pi;
    parameter Real V_cavity = 0.001;
    SnowBreathing.Components.LungsCO2 lungs annotation(
      Placement(visible = true, transformation(origin = {-76, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.CavityCO2 cavity(V = V_cavity) annotation(
      Placement(visible = true, transformation(origin = {-8, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    SnowBreathing.Components.DifussionSphereCO2 difussionSphere(R_in = (3 / 4 * V_cavity / pi) ^ (1 / 3)) annotation(
      Placement(visible = true, transformation(origin = {42, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
    connect(lungs.fluxConcA, cavity.fluxConcA) annotation(
      Line(points = {{-76, 10}, {-76, 10}, {-76, 18}, {-12, 18}, {-12, 18}}, color = {0, 12, 255}));
    connect(cavity.fluxConcB, difussionSphere.fluxConcB) annotation(
      Line(points = {{0, 18}, {42, 18}}, color = {251, 255, 0}));
end SnowBreathingCO2NoDT;
