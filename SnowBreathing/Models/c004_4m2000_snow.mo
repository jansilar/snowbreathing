within SnowBreathing.Models;

model c004_4m2000_snow
  SnowBreathing.Components.Cone cone1(useCO2Solubility = true)  annotation(
    Placement(visible = true, transformation(origin = {12, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real volInTot;
  Components.ExperimentalData data(caseID = "c004-4m2000")  annotation(
    Placement(visible = true, transformation(origin = {-48, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(cone1.fluxConcB, data.fluxConcCO2O2) annotation(
    Line(points = {{12, -4}, {-40, -4}}, color = {170, 170, 0}));
  der(volInTot) = cone1.fluxConcB.q;
  annotation(
    experiment(StartTime = 0, StopTime = 630, Tolerance = 1e-06, Interval = 0.02));
end c004_4m2000_snow;