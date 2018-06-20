within SnowBreathing;
package Identification
  model Tube
    parameter Modelica.SIunits.MolarVolume m3PerMole = 2.24e-3 "= 22.3 liters per mole STPD, though it is not";
    parameter String caseID = "c004-4m2000";
    parameter String fileCO2O2 = Modelica.Utilities.Files.loadResource("modelica://SnowBreathing") + "/../Data/" + caseID + "/CO2O2.mat";
    Physiolibrary.Chemical.Components.AdvectionStream advectionStream(
        useSolutionFlowInput=true)
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    Physiolibrary.Chemical.Sources.UnlimitedSolutionStorage
      unlimitedSolutionStorage(useConcentrationInput=true) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-10})));
    Physiolibrary.Chemical.Sources.UnlimitedSolutionStorage
      unlimitedSolutionStorage1(useConcentrationInput=true) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={110,-10})));
    Physiolibrary.Chemical.Sensors.ConcentrationMeasure concentrationMeasure
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Physiolibrary.Chemical.Components.Stream Stream(useSolutionFlowInput=true)
      annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
    Physiolibrary.Chemical.Components.Stream Stream1(useSolutionFlowInput=true)
      annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
      annotation (Placement(transformation(extent={{14,10},{34,30}})));
  protected
    Physiolibrary.Types.RealIO.VolumeFlowRateInput solutionFlow1
      annotation (Placement(transformation(extent={{-2,18},{2,22}})));
  public
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{126,-100},{146,-80}})));
    Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-36,-64})));
    Modelica.Blocks.Math.Add add1(k2=-1) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={104,-68})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTableFlow(
      columns=6:6,
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      fileName=fileCO2O2,
      tableName="CO2O2",
      tableOnFile=true)                                                                                                                                                                                      annotation (
      Placement(visible = true, transformation(origin={-18,70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTableCO2O2_MouthPiece(
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      tableOnFile=true,
      fileName=fileCO2O2,
      columns=4:5,
      tableName="CO2O2")    annotation (Placement(visible=true, transformation(
          origin={-90,70},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTableCO2O2_Cavity(
      columns=2:3,
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      tableOnFile=true,
      tableName="CO2O2",
      fileName=fileCO2O2) annotation (Placement(visible=true, transformation(
          origin={90,70},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Math.Gain gain(k=1/60000) "Conversion l/min to m3/s"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,42})));
    Physiolibrary.Chemical.Components.Diffusion diffusion(useConductanceInput=true)
      annotation (Placement(transformation(extent={{78,-40},{98,-20}})));
    Physiolibrary.Chemical.Components.Substance substance
      annotation (Placement(transformation(extent={{48,-40},{68,-20}})));
  public
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{62,0},{82,20}})));
    Physiolibrary.Types.Constants.DiffusionPermeabilityConst
      diffusionPermeability(k=1.6666666666667e-11)
      annotation (Placement(transformation(extent={{46,24},{54,32}})));
    Physiolibrary.Types.Constants.DiffusionPermeabilityConst
      diffusionPermeability1(k=16.666666666667)
      annotation (Placement(transformation(extent={{46,-10},{54,-2}})));
  protected
    Modelica.Blocks.Interfaces.RealInput u1
                 "Connector of Real input signal 2"
      annotation (Placement(transformation(extent={{-82,18},{-78,22}})));
  protected
    Modelica.Blocks.Interfaces.RealInput u2
                 "Connector of Real input signal 2"
      annotation (Placement(transformation(extent={{108,18},{112,22}})));
  public
    Physiolibrary.Chemical.Sensors.ConcentrationMeasure concentrationMeasure1
      annotation (Placement(transformation(extent={{68,-52},{88,-32}})));
    Modelica.Blocks.Math.Gain gain_MP_conversion(k=1/100/m3PerMole)
      "Conversion % fraction to mol/m3" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,42})));
    Modelica.Blocks.Math.Gain gain_CA_conversion1(k=1/100/m3PerMole)
      "Conversion % fraction to mol/m3" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={110,42})));
  equation
    connect(unlimitedSolutionStorage.q_out, Stream.q_in) annotation (Line(
        points={{-80,-20},{-80,-30},{-60,-30}},
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
    connect(advectionStream.solutionFlow, solutionFlow1)
      annotation (Line(points={{0,-23},{0,20}}, color={0,0,127}));
    connect(Stream1.solutionFlow, solutionFlow1) annotation (Line(points={{30,-23},
            {30,0},{0,0},{0,20}},      color={0,0,127}));
    connect(Stream.solutionFlow, solutionFlow1) annotation (Line(points={{-50,
            -23},{-50,0},{0,0},{0,20}}, color={0,0,127}));
    connect(greaterThreshold.u, solutionFlow1)
      annotation (Line(points={{12,20},{0,20}}, color={0,0,127}));
    connect(add.u1, concentrationMeasure.concentration)
      annotation (Line(points={{-30,-52},{-30,-38}}, color={0,0,127}));
    connect(add.u2, u1) annotation (Line(points={{-42,-52},{-100,-52},{-100,20},{-80,
            20}},              color={0,0,127}));
    connect(unlimitedSolutionStorage.concentration, u1)
      annotation (Line(points={{-80,0},{-80,20}},   color={0,0,127}));
    connect(add1.u1, concentrationMeasure1.concentration)
      annotation (Line(points={{98,-56},{98,-50},{78,-50}},
                                                   color={0,0,127}));
    connect(add.y, switch1.u3) annotation (Line(points={{-36,-75},{-36,-98},{124,-98}},
                   color={0,0,127}));
    connect(add1.y, switch1.u1)
      annotation (Line(points={{104,-79},{104,-82},{124,-82}},
                                                            color={0,0,127}));
    connect(add1.u2, u2) annotation (Line(points={{110,-56},{146,-56},{146,20},{110,
            20}},           color={0,0,127}));
    connect(unlimitedSolutionStorage1.concentration, u2)
      annotation (Line(points={{110,0},{110,20}}, color={0,0,127}));
    connect(greaterThreshold.y, switch1.u2)
      annotation (Line(points={{35,20},{38,20},{38,-90},{124,-90}},
                                                          color={255,0,255}));
    connect(solutionFlow1, gain.y)
      annotation (Line(points={{0,20},{0,31}}, color={0,0,127}));
    connect(combiTimeTableFlow.y[1], gain.u) annotation (Line(points={{-7,70},{0,70},
            {0,54},{2.22045e-15,54}}, color={0,0,127}));
    connect(Stream1.q_out, substance.q_out) annotation (Line(
        points={{40,-30},{58,-30}},
        color={107,45,134},
        thickness=1));
    connect(substance.q_out, diffusion.q_in) annotation (Line(
        points={{58,-30},{78,-30}},
        color={107,45,134},
        thickness=1));
    connect(diffusion.q_out, unlimitedSolutionStorage1.q_out) annotation (Line(
        points={{98,-30},{110,-30},{110,-20}},
        color={107,45,134},
        thickness=1));
    connect(switch2.u2, greaterThreshold.y) annotation (Line(points={{60,10},{38,10},
            {38,20},{35,20}}, color={255,0,255}));
    connect(diffusion.conductance, switch2.y)
      annotation (Line(points={{88,-26},{88,10},{83,10}}, color={0,0,127}));
    connect(switch2.u3, diffusionPermeability1.y)
      annotation (Line(points={{60,2},{58,2},{58,-6},{55,-6}}, color={0,0,127}));
    connect(switch2.u1, diffusionPermeability.y) annotation (Line(points={{60,18},
            {58,18},{58,28},{55,28}}, color={0,0,127}));
    connect(advectionStream.q_out, Stream1.q_in) annotation (Line(
        points={{10,-30},{20,-30}},
        color={107,45,134},
        thickness=1));
    connect(diffusion.q_in, concentrationMeasure1.q_in) annotation (Line(
        points={{78,-30},{78,-42}},
        color={107,45,134},
        thickness=1));
    connect(u1, gain_MP_conversion.y)
      annotation (Line(points={{-80,20},{-80,31}}, color={0,0,127}));
    connect(combiTimeTableCO2O2_MouthPiece.y[1], gain_MP_conversion.u)
      annotation (Line(points={{-79,70},{-80,70},{-80,54}}, color={0,0,127}));
    connect(u2, gain_CA_conversion1.y)
      annotation (Line(points={{110,20},{110,31}}, color={0,0,127}));
    connect(combiTimeTableCO2O2_Cavity.y[1], gain_CA_conversion1.u)
      annotation (Line(points={{101,70},{110,70},{110,54}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {160,100}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,100}})));
  end Tube;

  model test
      parameter String caseID = "c004-4m2000";
    parameter String fileCO2O2 = Modelica.Utilities.Files.loadResource("modelica://SnowBreathing") + "/../Data/" + caseID + "/CO2O2.mat";

      Modelica.Blocks.Sources.CombiTimeTable combiTimeTableFlow(
      columns=6:6,
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
      fileName=fileCO2O2,
      tableName="CO2O2",
      tableOnFile=true)                                                                                                                                                                                      annotation (
      Placement(visible = true, transformation(origin={-18,70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));


    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-80,-40},{92,22}},
            lineColor={28,108,200},
            textString="%fileCO2O2%")}),                           Diagram(
          coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-80,-40},{92,22}},
            lineColor={28,108,200},
            textString="%fileCO2O2%")}));
  end test;
end Identification;
