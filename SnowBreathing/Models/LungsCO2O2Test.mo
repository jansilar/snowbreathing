within SnowBreathing.Models;

model LungsCO2O2Test
  Components.LungsCO2O2 lungs21 annotation(
    Placement(visible = true, transformation(origin = {-52, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.StreamTestVolumeCO2O2 streamTestVolume21 annotation(
    Placement(visible = true, transformation(origin = {18, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(lungs21.fluxConcA, streamTestVolume21.fluxConcB) annotation(
    Line(points = {{-52, 18}, {18, 18}, {18, 12}, {18, 12}}, color = {0, 12, 255}));

end LungsCO2O2Test;