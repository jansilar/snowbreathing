within SnowBreathing.Models;

model SnowBreathingCO2O2SolNoDT
    constant Real pi = Modelica.Constants.pi;
    parameter Real V_cavity = 0.001;
    SnowBreathing.Components.LungsCO2O2 lungs annotation(
      Placement(visible = true, transformation(origin = {-60, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.CavityCO2O2 cavity(V = V_cavity) annotation(
      Placement(visible = true, transformation(origin = {-4, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.DifussionSphereCO2O2 difussionSphereCO2O2Sol1(useCO2Solubility = true) annotation(
      Placement(visible = true, transformation(origin = {50, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
    connect(cavity.fluxConcB, difussionSphereCO2O2Sol1.fluxConcB) annotation(
      Line(points = {{4, 2}, {50, 2}, {50, 2}, {50, 2}}, color = {170, 170, 0}));
    connect(lungs.fluxConcA, cavity.fluxConcA) annotation(
      Line(points = {{-60, -4}, {-58, -4}, {-58, 2}, {-8, 2}, {-8, 2}}, color = {0, 12, 255}));
end SnowBreathingCO2O2SolNoDT;
