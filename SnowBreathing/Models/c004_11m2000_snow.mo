within SnowBreathing.Models;

model c004_11m2000_snow
  SnowBreathing.Components.Cone cone1(D_CO2 = 2e-4, D_O2 = 2e-4,useCO2Solubility = true)  annotation(
    Placement(visible = true, transformation(origin = {-2,-12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real volInTot;
  SnowBreathing.Components.ExperimentalData experimentalData1(caseID = "c004-11m2000")  annotation(
    Placement(visible = true, transformation(origin = {-58, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(experimentalData1.fluxConcCO2O2, cone1.fluxConcB) annotation(
    Line(points = {{-50, -12}, {-2, -12}, {-2, -12}, {-2, -12}}, color = {0, 12, 255}));
  der(volInTot) = cone1.fluxConcB.q;
  annotation(
    experiment(StartTime = 0, StopTime = 580, Tolerance = 1e-06, Interval = 0.02));
end c004_11m2000_snow;