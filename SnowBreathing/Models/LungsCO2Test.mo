within SnowBreathing.Models;

model LungsCO2Test
  Components.LungsCO2 lungs annotation(
    Placement(visible = true, transformation(origin = {-66, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.StreamTestVolumeCO2 streamTestVolume(v_start = 0.001, vCO2_start = 0)  annotation(
    Placement(visible = true, transformation(origin = {-6, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(lungs.fluxConcA, streamTestVolume.fluxConcB) annotation(
    Line(points = {{-66, 20}, {-66, 20}, {-66, 30}, {-6, 30}, {-6, 30}, {-6, 30}}, color = {0, 12, 255}));

end LungsCO2Test;