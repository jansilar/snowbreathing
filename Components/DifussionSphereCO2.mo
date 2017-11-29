within SnowBreathing.Components;

model DifussionSphereCO2
  extends SnowBreathing.Components.DifussionSphereCO2_base;
equation
//Snow
  der(CO2) + (q / (4 * pi * omega.x ^ 2) - 2 * D / omega.x) * pder(CO2, x) - D * pder(CO2, x, x) = 0 indomain omega "the advection-diffusion equation";
end DifussionSphereCO2;