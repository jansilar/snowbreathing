within SnowBreathing;
package Identification
  model Tube
    Components.ExperimentalData experimentalData
      annotation (Placement(transformation(extent={{-56,6},{-36,26}})));
    Physiolibrary.Chemical.Components.AdvectionStream advectionStream(
        useSolutionFlowInput=true)
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    Physiolibrary.Chemical.Sources.UnlimitedSolutionStorage
      unlimitedSolutionStorage(useConcentrationInput=true) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-20})));
    Physiolibrary.Chemical.Sources.UnlimitedSolutionStorage
      unlimitedSolutionStorage1(useConcentrationInput=true) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={80,-20})));
    Physiolibrary.Chemical.Sensors.ConcentrationMeasure concentrationMeasure
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Physiolibrary.Chemical.Sensors.ConcentrationMeasure concentrationMeasure1
      annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
    Physiolibrary.Chemical.Components.Stream Stream(useSolutionFlowInput=true)
      annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
    Physiolibrary.Chemical.Components.Stream Stream1(useSolutionFlowInput=true)
      annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
      annotation (Placement(transformation(extent={{20,10},{40,30}})));
  protected
    Physiolibrary.Types.RealIO.VolumeFlowRateInput solutionFlow1
      annotation (Placement(transformation(extent={{-2,18},{2,22}})));
  public
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
    Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-36,-64})));
    Modelica.Blocks.Math.Add add1(k2=-1) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={36,-64})));
  protected
    Modelica.Blocks.Interfaces.RealInput u1
                 "Connector of Real input signal 2"
      annotation (Placement(transformation(extent={{-82,18},{-78,22}})));
  protected
    Modelica.Blocks.Interfaces.RealInput u2
                 "Connector of Real input signal 2"
      annotation (Placement(transformation(extent={{78,18},{82,22}})));
  equation
    connect(advectionStream.q_out, concentrationMeasure1.q_in) annotation (Line(
        points={{10,-30},{30,-30}},
        color={107,45,134},
        thickness=1));
    connect(unlimitedSolutionStorage.q_out, Stream.q_in) annotation (Line(
        points={{-80,-30},{-60,-30}},
        color={107,45,134},
        thickness=1));
    connect(concentrationMeasure.q_in, Stream.q_out) annotation (Line(
        points={{-30,-30},{-40,-30}},
        color={107,45,134},
        thickness=1));
    connect(concentrationMeasure.q_in, advectionStream.q_in) annotation (Line(
        points={{-30,-30},{-10,-30}},
        color={107,45,134},
        thickness=1));
    connect(unlimitedSolutionStorage1.q_out, Stream1.q_out) annotation (Line(
        points={{80,-30},{60,-30}},
        color={107,45,134},
        thickness=1));
    connect(concentrationMeasure1.q_in, Stream1.q_in) annotation (Line(
        points={{30,-30},{40,-30}},
        color={107,45,134},
        thickness=1));
    connect(advectionStream.solutionFlow, solutionFlow1)
      annotation (Line(points={{0,-23},{0,20}}, color={0,0,127}));
    connect(Stream1.solutionFlow, solutionFlow1) annotation (Line(points={{50,
            -23},{50,0},{0,0},{0,20}}, color={0,0,127}));
    connect(Stream.solutionFlow, solutionFlow1) annotation (Line(points={{-50,
            -23},{-50,0},{0,0},{0,20}}, color={0,0,127}));
    connect(greaterThreshold.u, solutionFlow1)
      annotation (Line(points={{18,20},{0,20}}, color={0,0,127}));
    connect(add.u1, concentrationMeasure.concentration)
      annotation (Line(points={{-30,-52},{-30,-38}}, color={0,0,127}));
    connect(add.u2, u1) annotation (Line(points={{-42,-52},{-100,-52},{-100,0},
            {-80,0},{-80,20}}, color={0,0,127}));
    connect(unlimitedSolutionStorage.concentration, u1)
      annotation (Line(points={{-80,-10},{-80,20}}, color={0,0,127}));
    connect(add1.u1, concentrationMeasure1.concentration)
      annotation (Line(points={{30,-52},{30,-38}}, color={0,0,127}));
    connect(add.y, switch1.u3) annotation (Line(points={{-36,-75},{-36,-98},{58,
            -98}}, color={0,0,127}));
    connect(add1.y, switch1.u1)
      annotation (Line(points={{36,-75},{36,-82},{58,-82}}, color={0,0,127}));
    connect(add1.u2, u2) annotation (Line(points={{42,-52},{100,-52},{100,0},{
            80,0},{80,20}}, color={0,0,127}));
    connect(unlimitedSolutionStorage1.concentration, u2)
      annotation (Line(points={{80,-10},{80,20}}, color={0,0,127}));
    connect(greaterThreshold.y, switch1.u2)
      annotation (Line(points={{41,20},{58,20},{58,-90}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Tube;
end Identification;
