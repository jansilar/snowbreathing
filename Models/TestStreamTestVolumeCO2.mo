within SnowBreathing.Models;

model TestStreamTestVolumeCO2
  SnowBreathing.Components.PumpConstCO2 pump1 annotation(
    Placement(visible = true, transformation(origin = {-4, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
  Components.StreamTestVolumeCO2 streamTestVolume1 annotation(
    Placement(visible = true, transformation(origin = {-62, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
  Components.StreamTestVolumeCO2 streamTestVolume2(vCO2_start = 0) annotation(
    Placement(visible = true, transformation(origin = {76, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
equation
  connect(pump1.fluxConcB, streamTestVolume2.fluxConcB) annotation(
    Line(points = {{6, 6}, {76, 6}, {76, 6}, {76, 6}}, color = {251, 255, 0}));
  connect(pump1.fluxConcA, streamTestVolume1.fluxConcB) annotation(
    Line(points = {{-12, 6}, {-62, 6}, {-62, 6}, {-62, 6}}, color = {0, 12, 255}));
end TestStreamTestVolumeCO2;