within SnowBreathing.Components;
model ExperimentalData
  extends Modelica.Icons.Record;
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTableCO2O2(columns = 2:3, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = fileCO2O2, tableName = "CO2O2", tableOnFile = true)
   annotation(
    Placement(visible = true, transformation(origin = {-42, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTableFlow(columns = 2:2, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = fileFlow, tableName = "Flow", tableOnFile = true)
   annotation(
    Placement(visible = true, transformation(origin = {-42, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.FluxConcCO2O2 fluxConcCO2O2 annotation(
    Placement(visible = true, transformation(origin = {84, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {84, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter String caseID;
  Real CO2_act;
  Real O2_act;
  parameter String fileCO2O2 = "Data/" + caseID + "/CO2O2.mat"; //Modelica.Utilities.Files.loadResource("modelica://../Data/" + caseID + "/CO2O2.mat");
  parameter String fileFlow = "Data/" + caseID + "/Flow.mat"; //Modelica.Utilities.Files.loadResource("modelica://../Data/" + caseID + "/Flow.mat");
equation
  combiTimeTableCO2O2.y[1]/100 = fluxConcCO2O2.CO2; //percent to fraction
  combiTimeTableCO2O2.y[2]/100 = fluxConcCO2O2.O2;  //percent to fraction
  combiTimeTableFlow.y[1]/60000 = fluxConcCO2O2.q;  //units in table are l/min, we use m3/s
  CO2_act = actualStream(fluxConcCO2O2.CO2);
  O2_act = actualStream(fluxConcCO2O2.O2);
end ExperimentalData;