within SnowBreathing.Models;

model test
  Components.ExperimentalData experimentalData1(caseID = "c004-8S2000")  annotation(
    Placement(visible = true, transformation(origin = {-66, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

annotation(
    experiment(StartTime = 0, StopTime = 611, Tolerance = 1e-06, Interval = 0.04));end test;