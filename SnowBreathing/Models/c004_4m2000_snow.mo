within SnowBreathing.Models;

model c004_4m2000_snow
  Components.ExperimentalData.data_c004_4m2000 data_c004_4m2000 annotation(
    Placement(visible = true, transformation(origin = {-60, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.Cone cone1 annotation(
    Placement(visible = true, transformation(origin = {-2,-12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(data_c004_4m2000.fluxConcCO2O2, cone1.fluxConcB) annotation(
    Line(points = {{-52, 8}, {-32, 8}, {-32, -12}, {-2, -12}}, color = {0, 12, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 332, Tolerance = 1e-06, Interval = 0.02));
end c004_4m2000_snow;