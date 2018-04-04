within SnowBreathing.Components;

model Cone
  extends SnowBreathing.Components.DifussionSphereCO2O2(theta=0.24517);
equation

annotation(
    Icon(graphics = {Polygon(origin = {-2, 0}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{3, 10}, {-56, 100}, {-98, 100}, {-98, -100}, {102, -100}, {102, 100}, {54, 100}, {3, 10}}), Rectangle(origin = {-1, 1}, extent = {{-99, 99}, {101, -101}})}));end Cone;