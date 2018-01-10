within SnowBreathing.Models;

model CavityTestCO2
  SnowBreathing.Components.StreamTestVolumeCO2 streamTestVolume1(v_start = 100000, vCO2_start = 100000)  annotation(
    Placement(visible = true, transformation(origin = {-82, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.StreamTestVolumeCO2 streamTestVolume2(v_start = 0, vCO2_start = 0)  annotation(
    Placement(visible = true, transformation(origin = {62, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.CavityCO2 cavity1(V = 1, VCO2(start = 0))  annotation(
    Placement(visible = true, transformation(origin = {6, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.PumpConstCO2 pumpConst1 annotation(
    Placement(visible = true, transformation(origin = {-38, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(pumpConst1.fluxConcB, cavity1.fluxConcA) annotation(
    Line(points = {{-28, -6}, {2, -6}, {2, -6}, {2, -6}}, color = {251, 255, 0}));
  connect(streamTestVolume1.fluxConcB, pumpConst1.fluxConcA) annotation(
    Line(points = {{-82, -4}, {-46, -4}, {-46, -6}, {-46, -6}}, color = {251, 255, 0}));
  connect(cavity1.fluxConcB, streamTestVolume2.fluxConcB) annotation(
    Line(points = {{14, -6}, {62, -6}, {62, -4}, {62, -4}}, color = {251, 255, 0}));
end CavityTestCO2;