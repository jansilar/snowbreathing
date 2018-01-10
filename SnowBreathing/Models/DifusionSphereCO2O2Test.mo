within SnowBreathing.Models;

model DifusionSphereCO2O2Test
  Components.StreamTestVolumeCO2O2 streamTestVolume21(VO2_start = 1, vCO2_start = 1, v_start = 10)  annotation(
    Placement(visible = true, transformation(origin = {-62, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.PumpConstCO2O2 pumpConst21(q = 0.00001)  annotation(
    Placement(visible = true, transformation(origin = {-4, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.DifussionSphereCO2O2 difussionSphere21(O2_init = 0, O2_out = 0)  annotation(
    Placement(visible = true, transformation(origin = {44, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(pumpConst21.fluxConcB, difussionSphere21.fluxConcB) annotation(
    Line(points = {{6, 4}, {44, 4}, {44, 4}, {44, 4}}, color = {170, 170, 0}));
  connect(streamTestVolume21.fluxConcB, pumpConst21.fluxConcA) annotation(
    Line(points = {{-62, 4}, {-12, 4}, {-12, 4}, {-12, 4}}, color = {170, 170, 0}));

end DifusionSphereCO2O2Test;