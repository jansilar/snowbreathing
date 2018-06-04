within SnowBreathing.Components;

model ExperimentalData
  extends Modelica.Icons.Record;
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTableCO2O2(columns = 2:3, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = fileCO2O2, tableName = "CO2O2", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-42, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTableFlow(columns = 2:2, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = fileFlow, tableName = "Flow", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-42, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.FluxConcCO2O2 fluxConcCO2O2 annotation(
    Placement(visible = true, transformation(origin = {84, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {84, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter String caseID;
  Real CO2_act;
  Real O2_act;
  parameter String fileCO2O2 = "Data/" + caseID + "/CO2O2.mat";
  //Modelica.Utilities.Files.loadResource("modelica://../Data/" + caseID + "/CO2O2.mat");
  parameter String fileFlow = "Data/" + caseID + "/Flow.mat";
  //Modelica.Utilities.Files.loadResource("modelica://../Data/" + caseID + "/Flow.mat");
  Real CO2OutSum(start = 0, fixed = true), O2OutSum(start = 0, fixed = true) "volume of CO2 and O2 that left the component";
  Real CO2InExpSum(start = 0, fixed = true), O2InExpSum(start = 0, fixed = true) "volume of CO2 and O2 that entered the component according to experimental data";
  Modelica.Blocks.Interfaces.RealOutput CO2Out annotation(
    Placement(visible = true, transformation(origin = {88, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {36, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput O2Out annotation(
    Placement(visible = true, transformation(origin = {86, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {62,90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput qOut annotation(
    Placement(visible = true, transformation(origin = {88, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {88,90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
//percent to fraction
  combiTimeTableCO2O2.y[1] / 100 = fluxConcCO2O2.CO2;
  CO2Out = fluxConcCO2O2.CO2;
//percent to fraction
  combiTimeTableCO2O2.y[2] / 100 = fluxConcCO2O2.O2;
  O2Out = fluxConcCO2O2.O2;
//units in table are l/min, we use m3/s  
  -combiTimeTableFlow.y[1] / 60000 = fluxConcCO2O2.q;
  qOut = fluxConcCO2O2.q;
  CO2_act = actualStream(fluxConcCO2O2.CO2);
  O2_act = actualStream(fluxConcCO2O2.O2);
  if fluxConcCO2O2.q > 0 then
    der(CO2OutSum) = 0;
    der(O2OutSum) = 0;
    der(CO2InExpSum) = fluxConcCO2O2.q * combiTimeTableCO2O2.y[1] / 100;
    der(O2InExpSum) = fluxConcCO2O2.q * combiTimeTableCO2O2.y[2] / 100;
  else
    der(CO2OutSum) = -fluxConcCO2O2.q * fluxConcCO2O2.CO2;
    der(O2OutSum) = fluxConcCO2O2.q * fluxConcCO2O2.O2;
    der(CO2InExpSum) = 0;
    der(O2InExpSum) = 0;
  end if;
end ExperimentalData;