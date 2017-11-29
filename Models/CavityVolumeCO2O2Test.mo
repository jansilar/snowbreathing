within SnowBreathing.Models;

model CavityVolumeCO2O2Test
  Components.StreamTestVolumeCO2O2 streamTestVolume21(V(fixed = true), VCO2(fixed = true), VO2(fixed = true), VO2_start = 8, vCO2_start = 1)  annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SnowBreathing.Components.StreamTestVolumeCO2O2 streamTestVolume22(VO2_start = 0, vCO2_start = 0)  annotation(
    Placement(visible = true, transformation(origin = {58, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.PumpConstCO2O2 pumpConst21 annotation(
    Placement(visible = true, transformation(origin = {-28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.CavityCO2O2 cavity21 annotation(
    Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(cavity21.fluxConcB, streamTestVolume22.fluxConcB) annotation(
    Line(points = {{24, 0}, {58, 0}, {58, 4}, {58, 4}}, color = {170, 170, 0}));
  connect(pumpConst21.fluxConcB, cavity21.fluxConcA) annotation(
    Line(points = {{-18, 0}, {12, 0}, {12, 0}, {12, 0}}, color = {170, 170, 0}));
  connect(streamTestVolume21.fluxConcB, pumpConst21.fluxConcA) annotation(
    Line(points = {{-60, 0}, {-36, 0}, {-36, 0}, {-36, 0}}, color = {170, 170, 0}));

end CavityVolumeCO2O2Test;