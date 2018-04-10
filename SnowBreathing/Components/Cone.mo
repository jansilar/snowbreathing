within SnowBreathing.Components;

model Cone
  extends SnowBreathing.Components.DifussionSphereCO2O2(theta=0.24517, R_in = R_cavity, R_out = R_cavity + R_snow);
  parameter Real V_cavity (unit = "m3")= 0.002 "cavity volume";
  parameter Real R_cavity (unit = "m") = (V_cavity*3/4/pi)^(1/3) "cavity radius";
  parameter Real R_snow (unit = "m") = 1 "snow thicknes";
equation

annotation(
    Icon(graphics = {Polygon(origin = {-2, 0}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{3, 10}, {-56, 100}, {-98, 100}, {-98, -100}, {102, -100}, {102, 100}, {54, 100}, {3, 10}}), Rectangle(origin = {-1, 1}, extent = {{-99, 99}, {101, -101}})}));end Cone;