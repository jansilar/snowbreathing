within SnowBreathing.Models;

model c004_11m2000_snow
  Components.ExperimentalData.data_c004_11m2000 data annotation(
    Placement(visible = true, transformation(origin = {-60, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.Cone cone1(useCO2Solubility = true, wc = 100)  annotation(
    Placement(visible = true, transformation(origin = {-2,-12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real volInTot;
equation
  connect(data.fluxConcCO2O2, cone1.fluxConcB) annotation(
    Line(points = {{-52, 8}, {-32, 8}, {-32, -12}, {-2, -12}}, color = {0, 12, 255}));
  der(volInTot) = cone1.fluxConcB.q;
  annotation(
    experiment(StartTime = 0, StopTime = 630, Tolerance = 1e-06, Interval = 0.02));
end c004_11m2000_snow;