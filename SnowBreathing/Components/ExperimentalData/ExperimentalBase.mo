within SnowBreathing.Components.ExperimentalData;
partial model ExperimentalBase
  extends Modelica.Icons.Record;
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTableCO2O2 annotation(
    Placement(visible = true, transformation(origin = {-42, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTableFlow annotation(
    Placement(visible = true, transformation(origin = {-42, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.FluxConcCO2O2 fluxConcCO2O2 annotation(
    Placement(visible = true, transformation(origin = {84, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {84, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real CO2_act;
  Real O2_act;
equation
  combiTimeTableCO2O2.y[1] = fluxConcCO2O2.CO2;
  combiTimeTableCO2O2.y[2] = fluxConcCO2O2.O2;
  combiTimeTableFlow.y[1] = fluxConcCO2O2.q;
  CO2_act = actualStream(fluxConcCO2O2.CO2);
  O2_act = actualStream(fluxConcCO2O2.O2);
end ExperimentalBase;