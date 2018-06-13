within SnowBreathing.Models;

model SolTest2
  SolTest solubilityModel(cone1(useCO2Solubility = true))  annotation(
    Placement(visible = true, transformation(origin = {-46, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SolTest noSolubilityModel annotation(
    Placement(visible = true, transformation(origin = {-44, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

annotation(
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-06, Interval = 0.001));end SolTest2;