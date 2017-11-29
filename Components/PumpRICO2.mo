within SnowBreathing.Components;

model PumpRICO2
  extends SnowBreathing.Components.PumpBaseCO2;
    Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-4, 92}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-4, 92}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
equation
  fluxConcA.q = u;
end PumpRICO2;