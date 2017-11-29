within SnowBreathing.Models;

model DifusionSphereCO2O2SolTest
  Components.StreamTestVolumeCO2O2 streamTestVolume21(VO2_start = 1, vCO2_start = 1, v_start = 10) annotation(
    Placement(visible = true, transformation(origin = {-62, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.PumpConstCO2O2 pumpConst21(q = 0.00001) annotation(
    Placement(visible = true, transformation(origin = {-4, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Components.DifussionSphereCO2O2Sol difussionSphereCO2O2Sol1(O2_init = 0)  annotation(
    Placement(visible = true, transformation(origin = {40, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(pumpConst21.fluxConcB, difussionSphereCO2O2Sol1.fluxConcB) annotation(
    Line(points = {{6, 4}, {40, 4}, {40, 4}, {40, 4}}, color = {170, 170, 0}));
  connect(streamTestVolume21.fluxConcB, pumpConst21.fluxConcA) annotation(
    Line(points = {{-62, 4}, {-12, 4}, {-12, 4}, {-12, 4}}, color = {170, 170, 0}));
end DifusionSphereCO2O2SolTest;
