within SnowBreathing.Components;

model SphericalSectorCO2O2
  extends SnowBreathing.Components.SphericalSectorCO2(redeclare Connectors.FluxConcCO2O2B fluxConcB);
  field Real O2(domain = omega, unit = "m3/m3") "O2 concentration";
  parameter Real O2_out(unit = "m3/m3") = 0.2 "O2 concentration out of the sphere";
  parameter Real O2_init(unit = "m3/m3") = 0.2 "initial O2 concentartion";
initial equation
  O2 = O2_init indomain omega "O2 initial concentartion";
equation
  O2 = if exhale then inStream(fluxConcB.O2) else extrapolateField(O2) indomain omega.left "left BC duringexhalation, extrapolation during inhalation";
  fluxConcB.O2 = O2 indomain omega.left;
  der(O2) + (q / (facA * omega.x ^ 2) - 2 * D / omega.x) * pder(O2, x) - D * pder(O2, x, x) = 0 indomain omega "the advection-diffusion equation";
  O2 = if exhale then extrapolateField(O2) else O2_out indomain omega.right "right/outer BC or extrapolation";
end SphericalSectorCO2O2;