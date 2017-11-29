within SnowBreathing.Models;

model TestDTStepCO2O2
  Components.StreamTestVolumeCO2O2 streamTestVolumeCO2O21 annotation(
    Placement(visible = true, transformation(origin = {-52, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.PumpConstCO2O2 pumpConstCO2O21 annotation(
    Placement(visible = true, transformation(origin = {-14, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.TemperatureStepCO2O2 temperatureStepCO2O21 annotation(
    Placement(visible = true, transformation(origin = {30, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.StreamTestVolumeCO2O2 streamTestVolumeCO2O22(VO2_start = 0, v_start = 1.0e-16)  annotation(
    Placement(visible = true, transformation(origin = {72, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(temperatureStepCO2O21.fluxConcB, streamTestVolumeCO2O22.fluxConcB) annotation(
    Line(points = {{40, 18}, {72, 18}, {72, 20}, {72, 20}}, color = {170, 170, 0}));
  connect(pumpConstCO2O21.fluxConcB, temperatureStepCO2O21.fluxConcA) annotation(
    Line(points = {{-4, 18}, {20, 18}, {20, 18}, {22, 18}}, color = {170, 170, 0}));
  connect(streamTestVolumeCO2O21.fluxConcB, pumpConstCO2O21.fluxConcA) annotation(
    Line(points = {{-52, 16}, {-22, 16}, {-22, 18}, {-22, 18}}, color = {170, 170, 0}));

end TestDTStepCO2O2;