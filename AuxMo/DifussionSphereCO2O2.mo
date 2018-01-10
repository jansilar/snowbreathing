within SnowBreathing.Components;

model DifussionSphereCO2O2
    extends SnowBreathing.Components.DifussionSphereCO2O2_discretised;
    Connectors.FluxConcCO2O2B fluxConcB annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  fluxConcB.q = fluxConcB_q;
  fluxConcB.CO2 = fluxConcB_CO2;
  fluxConcB.CO2O2 = fluxConcB_CO2O2;
        annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Ellipse(origin = {2, -12}, lineColor = {129, 207, 255}, fillColor = {129, 207, 255}, fillPattern = FillPattern.Sphere, extent = {{-102, 112}, {98, -88}}, endAngle = 360)})
        );
end DifussionSphereCO2O2;