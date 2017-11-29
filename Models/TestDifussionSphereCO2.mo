within SnowBreathing.Models;

model TestDifussionSphereCO2
    Components.DifussionSphereCO2 difussionSphere1 annotation(
      Placement(visible = true, transformation(origin = {50, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.StreamTestVolumeCO2 streamTestVolume1(V(fixed = true), VCO2(fixed = true), v_start = 200, vCO2_start = 100) annotation(
      Placement(visible = true, transformation(origin = {-66, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Components.PumpRICO2 pumpRI1 annotation(
      Placement(visible = true, transformation(origin = {2, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step step1(height = -0.1, offset = 0.1, startTime = 1) annotation(
      Placement(visible = true, transformation(origin = {-22, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.PumpRICO2 pumpRI2 annotation(
      Placement(visible = true, transformation(origin = {16, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step step2(height = -0.1, startTime = 3) annotation(
      Placement(visible = true, transformation(origin = {2, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.StreamTestVolumeCO2 streamTestVolume2(v_start = 1.0e-9, vCO2_start = 1.0e-9) annotation(
      Placement(visible = true, transformation(origin = {-32, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(streamTestVolume2.fluxConcB, pumpRI2.fluxConcA) annotation(
      Line(points = {{-38, 70}, {-54, 70}, {-54, 42}, {8, 42}, {8, 42}}, color = {251, 255, 0}));
    connect(pumpRI2.u, step2.y) annotation(
      Line(points = {{16, 52}, {16, 52}, {16, 72}, {14, 72}, {14, 72}}, color = {0, 0, 127}));
    connect(difussionSphere1.fluxConcB, pumpRI2.fluxConcB) annotation(
      Line(points = {{50, 2}, {52, 2}, {52, 42}, {24, 42}, {24, 42}}, color = {0, 12, 255}));
    connect(step1.y, pumpRI1.u) annotation(
      Line(points = {{-10, 24}, {2, 24}, {2, 12}, {2, 12}}, color = {0, 0, 127}));
    connect(pumpRI1.fluxConcB, difussionSphere1.fluxConcB) annotation(
      Line(points = {{10, 2}, {50, 2}, {50, 2}, {50, 2}}, color = {251, 255, 0}));
    connect(streamTestVolume1.fluxConcB, pumpRI1.fluxConcA) annotation(
      Line(points = {{-58, 4}, {-6, 4}, {-6, 2}, {-6, 2}}, color = {251, 255, 0}));
    annotation(
      experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.01));
end TestDifussionSphereCO2;
