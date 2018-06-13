within SnowBreathing.Components;

model CO2O2Source
  extends CO2Source(redeclare Connectors.FluxConcCO2O2 fluxConc);
  Modelica.Blocks.Interfaces.RealInput O2Input annotation(
    Placement(visible = true, transformation(origin = {-66, 34}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-78, 32}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  fluxConc.O2 = O2Input;
end CO2O2Source;