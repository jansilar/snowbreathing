within SnowBreathing.Models;

model LungsTrapTest
  Components.LungsCO2O2Trap lungsCO2O2Trap1 annotation(
    Placement(visible = true, transformation(origin = {-54, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.StreamTestVolumeCO2O2 streamTestVolumeCO2O21(VO2_start = 0, v_start = 1.0e-12)  annotation(
    Placement(visible = true, transformation(origin = {4, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(lungsCO2O2Trap1.fluxConcA, streamTestVolumeCO2O21.fluxConcB) annotation(
    Line(points = {{-54, 14}, {4, 14}, {4, 16}, {4, 16}}, color = {0, 12, 255}));

end LungsTrapTest;