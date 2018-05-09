within SnowBreathing.Components;

model ConeCompGrad
  extends SnowBreathing.Components.Cone;
  Modelica.Blocks.Sources.CombiTimeTable table(columns = 1:4, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = fileGrad, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, tableName = "GRAD", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-56, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter String caseID;
  parameter String fileGrad = "Data/" + caseID + "/" + caseID + "_grad.mat";

  constant Integer NRows = 13;
//  Real r;
//  discrete Real rOld;
  Real tGT;
  discrete Real tGTOld;
  discrete Real  rGT[NRows], CO2GT[NRows], O2GT[NRows];   //gradient table values
//  discrete Real  CO2GM[NRows];   /*, O2GM[NRows]*/
  //gradient model values
  discrete Integer ix;
//  discrete Real  CO2GD[NRows], O2GD[NRows]; //gradient table-model differences
  discrete Integer i;
initial algorithm
  CO2GT:= zeros(NRows);
  rGT:= zeros(NRows);
//  CO2GM:= zeros(NRows);
  tGTOld := table.y[1];
  i := 1"gradient sample index";
  ix := 1 "index in for model data"; 
equation
  tGT = table.y[1];
algorithm
  when tGT > pre(tGTOld) then //table time has changed, time of new grad measurement reached
    tGTOld := tGT;
    rGT[pre(i)] := table.y[2];
    CO2GT[pre(i)] := table.y[3];
    O2GT[pre(i)] := table.y[4];
//    Modelica.Utilities.Streams.print("t = " + String(time) + "\n r = " + String(rGT[pre(i)]) + "\n");
//    ix := 1;
    while omega.x[ix] < rGT[pre(i)] + R_in loop
      ix := ix + 1;
//      Modelica.Utilities.Streams.print("omega.x[ix] = " + String(omega.x[ix]) + "\n");
    end while;
    if ix > 1 then
      Modelica.Utilities.Streams.print("ix = " + String(ix) + "omega.x[ix] - R_in = " + String(omega.x[ix] - R_in) + "omega.x[ix-1] - R_in = " + String(omega.x[ix-1] - R_in) + "rGT = " + String(rGT[pre(i)]) + "\n ---------\n");
    else
      Modelica.Utilities.Streams.print("ix = " + String(ix) + "omega.x[ix] - R_in = " + String(omega.x[ix] - R_in) + "rGT = " + String(rGT[pre(i)]) + "\n ---------\n");
    end if;
//    CO2GM[i] := CO2[ix-1];// + (CO2[ix] - CO2[ix-1])/omega.dx *(r - omega.x[ix-1]);
    i := pre(i) + 1;
  end when;

annotation(
    Icon(graphics = {Line(origin = {-0.475442, -50.9566}, points = {{-85.3608, 15.8292}, {-61.3608, 3.82918}, {-21.3608, -8.17082}, {10.6392, -14.1708}, {44.6392, -16.1708}, {74.6392, -16.1708}, {84.6392, -16.1708}}, color = {0, 85, 255}, thickness = 0.5), Line(origin = {-4.34886, -57.5389}, points = {{-79.3608, 5.8292}, {-61.3608, -2.17082}, {-23.3608, -10.1708}, {16.6392, -12.1708}, {40.6392, -12.1708}, {74.6392, -12.1708}, {82.6392, -12.1708}, {88.6392, -12.1708}}, color = {255, 0, 0}, thickness = 0.5)}));
end ConeCompGrad;