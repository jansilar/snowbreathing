within SnowBreathing.Models;

model c004_4m2000_snow
  Components.ExperimentalData.data_c004_4m2000 data_c004_4m2000 annotation(
    Placement(visible = true, transformation(origin = {-60, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.DifussionSphereCO2O2 difussionSphereCO2O2 annotation(
    Placement(visible = true, transformation(origin = {-2, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(data_c004_4m2000.fluxConcCO2O2, difussionSphereCO2O2.fluxConcB) annotation(
    Line(points = {{-52, 8}, {-2, 8}, {-2, 8}, {-2, 8}}, color = {0, 12, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 332, Tolerance = 1e-06, Interval = 0.02));
end c004_4m2000_snow;