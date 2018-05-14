within SnowBreathing.Components;

model ConeCompGrad
  extends SnowBreathing.Components.Cone;
  Modelica.Blocks.Sources.CombiTimeTable table(columns = 1:4, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = fileGrad, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, tableName = "GRAD", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-56, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter String caseID "e.g. c013-12s2000";
  parameter String fileGrad = "Data/" + caseID + "/" + caseID + "_grad.mat";
  constant Integer NRows = 13 "number of gradient samples";
  Real tGT;   //gradient table mesurement time
  discrete Real tGTOld; //gradient table mesurement old time - pre does not work on continuous
  discrete Real  rGT[NRows], CO2GT[NRows], O2GT[NRows];   //gradient table values
  discrete Real  CO2GM[NRows], O2GM[NRows];               //gradient model values
  discrete Integer ix "index in for model data";
  discrete Real  CO2GD[NRows], O2GD[NRows]; //gradient table-model differences
  discrete Integer i "gradient sample index";
  discrete Real rGTCenter "distance of gradient sample from center of cavity/cone";
  discrete Real RMSCO2, RMSO2 "CO2/O2 rms error";
initial algorithm
  CO2GT:= zeros(NRows);
  rGT:= zeros(NRows);
  rGTCenter := 0;
  tGTOld := table.y[1];
  i := 1;
  ix := 1;
equation
  tGT = table.y[1];
algorithm
  when tGT > pre(tGTOld) then //table time has changed, time of new grad measurement reached
    tGTOld := tGT;
    rGTCenter := table.y[2] + R_in;
    rGT[pre(i)] := table.y[2];
    CO2GT[pre(i)] := table.y[3]/100;
    O2GT[pre(i)] := table.y[4]/100;
    while omega.x[ix] < rGTCenter loop
      ix := ix + 1;
    end while;
    if (ix > 1) then
        CO2GM[i] := CO2[ix-1] + (CO2[ix] - CO2[ix-1])/omega.dx *(rGTCenter - omega.x[ix-1]);
        O2GM[i] := O2[ix-1] + (O2[ix] - O2[ix-1])/omega.dx *(rGTCenter - omega.x[ix-1]);
    else
      CO2GM[i] := CO2[ix];
      O2GM[i]  := O2[ix];
    end if;
    CO2GD[i] := CO2GM[i] - CO2GT[i];
    O2GD[i]  := O2GM[i]  - O2GT[i];
    RMSCO2   := RMSCO2   + CO2GD[i]^2;
    RMSO2    := RMSO2    + O2GD[i]^2;
    i := pre(i) + 1;
  end when;

annotation(
    Icon(graphics = {Line(origin = {-0.475442, -50.9566}, points = {{-85.3608, 15.8292}, {-61.3608, 3.82918}, {-21.3608, -8.17082}, {10.6392, -14.1708}, {44.6392, -16.1708}, {74.6392, -16.1708}, {84.6392, -16.1708}}, color = {0, 85, 255}, thickness = 0.5), Line(origin = {-4.34886, -57.5389}, points = {{-79.3608, 5.8292}, {-61.3608, -2.17082}, {-23.3608, -10.1708}, {16.6392, -12.1708}, {40.6392, -12.1708}, {74.6392, -12.1708}, {82.6392, -12.1708}, {88.6392, -12.1708}}, color = {255, 0, 0}, thickness = 0.5)}));
end ConeCompGrad;