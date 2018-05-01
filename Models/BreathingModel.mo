within ;
package BreathingModel
  model Main
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Main;

  model TestLM
    OriginalDoLoi.LungMechanics_bckp lungMechanics_bckp
      annotation (Placement(transformation(extent={{-18,-24},{2,-4}})));
    Physiolibrary.Types.TorsoBusConnector RespiratoryControl_Bus annotation (
        Placement(
        visible=true,
        transformation(
          origin={-54,14},
          extent={{-20,-20},{20,20}},
          rotation=0),
        iconTransformation(
          origin={-100,0},
          extent={{-20,-20},{20,20}},
          rotation=-90)));
    Modelica.Blocks.Sources.Constant RR(k=12) annotation (Placement(visible=
            true, transformation(
          origin={-90,14},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Physiolibrary.Types.Constants.PressureConst P_mus_min(k(displayUnit="Pa")=
           -490.333) annotation (Placement(visible=true, transformation(
          origin={-92,-20},
          extent={{-4,-4},{4,4}},
          rotation=0)));
    LungMechanics lungMechanics
      annotation (Placement(transformation(extent={{-16,16},{4,36}})));
  equation
    connect(lungMechanics.RespiratoryControl_Bus, RespiratoryControl_Bus)
      annotation (Line(
        points={{-16,26},{-36,26},{-36,14},{-54,14}},
        color={129,194,194},
        thickness=1), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(lungMechanics_bckp.RespiratoryControl_Bus, RespiratoryControl_Bus)
      annotation (Line(
        points={{-18,-14},{-34,-14},{-34,14},{-54,14}},
        color={0,0,255},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(RR.y, RespiratoryControl_Bus.RR) annotation (Line(points={{-79,14},
            {-54,14}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(P_mus_min.y, RespiratoryControl_Bus.Pmus_min) annotation (Line(
          points={{-87,-20},{-54,-20},{-54,14}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TestLM;

  model LungMechanics
    Physiolibrary.Hydraulic.Components.Resistor R_ml(Resistance(displayUnit=
            "(Pa.s)/m3") = 100125.9, cond(displayUnit="m3/(Pa.s)")) annotation (
       Placement(visible=true, transformation(
          origin={-76,60},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Physiolibrary.Hydraulic.Components.Resistor R_lt(Resistance(displayUnit=
            "(Pa.s)/m3") = 33038.6039, cond(displayUnit="m3/(Pa.s)"))
      annotation (Placement(visible=true, transformation(
          origin={-30,60},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Physiolibrary.Hydraulic.Components.Resistor R_tb(Resistance(displayUnit=
            "(Pa.s)/m3") = 30037.76895, cond(displayUnit="m3/(Pa.s)"))
      annotation (Placement(visible=true, transformation(
          origin={10,60},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Physiolibrary.Hydraulic.Components.Resistor R_bA(Resistance(displayUnit=
            "(Pa.s)/m3") = 8012.03305, cond(displayUnit="m3/(Pa.s)"))
      annotation (Placement(visible=true, transformation(
          origin={50,60},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Airway C_tr(
      c(displayUnit="ml/mmHg") = 2.42692459e-08,
      zero_press_vol(displayUnit="ml") = 6.63e-06,
      init_vol(displayUnit="ml") = 1.85706e-05) annotation (Placement(visible=
            true, transformation(
          origin={-10,20},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Airway C_b(
      c(displayUnit="ml/mmHg") = 1.3358282e-07,
      zero_press_vol(displayUnit="ml") = 3.44e-05,
      init_vol(displayUnit="ml") = 0.000100159) annotation (Placement(visible=
            true, transformation(
          origin={30,20},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Physiolibrary.Types.Constants.PressureConst atmos_pressure(k(displayUnit=
            "Pa") = 0) annotation (Placement(visible=true, transformation(
          origin={-89.878,-93.7729},
          extent={{-5.72212,-5.82707},{5.72212,5.82707}},
          rotation=90)));
    SemestralProjectDoloi_2017.LungMechanics.Subsystems.Pmus pulmonaryMuscles
      annotation (Placement(visible=true, transformation(
          origin={30,-40},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Airway C_A(
      c(displayUnit="ml/mmHg") = 2.0394e-06,
      zero_press_vol(displayUnit="ml") = 0.00126288,
      init_vol(displayUnit="ml") = 0.00226696) annotation (Placement(visible=
            true, transformation(
          origin={70,20},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    SemestralProjectDoloi_2017.LungMechanics.Components.ElasticMembrane
      chestWall(c(displayUnit="m3/Pa") = 2.4932e-06, init_press(displayUnit=
            "Pa") = -490.333) annotation (Placement(visible=true,
          transformation(
          origin={30,-10},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Physiolibrary.Hydraulic.Sensors.FlowMeasure V_A_measure annotation (
        Placement(visible=true, transformation(
          origin={70,50},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Physiolibrary.Types.BusConnector busConnector1 annotation (Placement(
        visible=true,
        transformation(
          origin={60,-80},
          extent={{-20,-20},{20,20}},
          rotation=0),
        iconTransformation(
          origin={100,0},
          extent={{-20,-20},{20,20}},
          rotation=-90)));
    Physiolibrary.Hydraulic.Sensors.FlowMeasure totalAirFlow annotation (
        Placement(visible=true, transformation(
          origin={-54,60},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Airway C_l(
      c(displayUnit="l/mmHg") = 1.29503959e-08,
      zero_press_vol(displayUnit="ml") = 3.44e-05,
      init_vol(displayUnit="ml") = 4.07678e-05) annotation (Placement(visible=
            true, transformation(
          origin={-44,20},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Modelica.Blocks.Math.Add3 total_deadspace_vol annotation (Placement(visible=
           true, transformation(
          origin={-66,-20},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Physiolibrary.Types.TorsoBusConnector RespiratoryControl_Bus annotation (
        Placement(
        visible=true,
        transformation(
          origin={-20,-100},
          extent={{-20,-20},{20,20}},
          rotation=0),
        iconTransformation(
          origin={-100,0},
          extent={{-20,-20},{20,20}},
          rotation=-90)));
    Physiolibrary.Hydraulic.Sources.UnlimitedVolume unlimitedVolume(
        usePressureInput=true) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-90,-70})));
  equation
    connect(totalAirFlow.volumeFlow, busConnector1.totalFlow) annotation (Line(
        points={{-54,72},{92,72},{92,-80},{60,-80}},
        color={170,0,0},
        thickness=0.5));
    connect(total_deadspace_vol.y, busConnector1.volumeDeadspace) annotation (
        Line(
        points={{-66,-31},{-66,-80},{60,-80}},
        color={170,0,0},
        thickness=0.5));
    connect(V_A_measure.volumeFlow, busConnector1.alveolarFlow) annotation (
        Line(
        points={{82,50},{88,50},{88,-60},{63,-60},{63,-80},{60,-80}},
        color={170,0,0},
        thickness=0.5));
    connect(C_A.volume, busConnector1.volumeAlveoli) annotation (Line(
        points={{60,16},{54,16},{54,-80},{60,-80}},
        color={170,0,0},
        thickness=0.5));
    connect(pulmonaryMuscles.Pmus_min, RespiratoryControl_Bus.Pmus_min)
      annotation (Line(
        points={{20,-46},{-14,-46},{-14,-100},{-20,-100}},
        color={0,85,0},
        thickness=0.5));
    connect(pulmonaryMuscles.RR, RespiratoryControl_Bus.RR) annotation (Line(
        points={{20,-34},{-26,-34},{-26,-100},{-20,-100}},
        color={0,85,0},
        thickness=0.5));
    connect(C_A.q_out, chestWall.q_in) annotation (Line(
        points={{70,10},{70,0},{30,0}},
        color={0,0,127},
        thickness=0.5));
    connect(V_A_measure.q_out, C_A.q_in) annotation (Line(
        points={{70,40},{70,30}},
        color={0,0,127},
        thickness=0.5));
    connect(total_deadspace_vol.u3, C_l.volume) annotation (Line(
        points={{-74,-8},{-74,16},{-54,16}},
        color={170,0,0},
        thickness=0.5));
    connect(total_deadspace_vol.u1, C_b.volume) annotation (Line(
        points={{-58,-8},{-58,-2},{-58,-2},{-58,4},{10,4},{10,16},{20,16}},
        color={170,0,0},
        thickness=0.5));
    connect(C_tr.volume, total_deadspace_vol.u2) annotation (Line(
        points={{-20,16},{-30,16},{-30,8},{-66,8},{-66,-8}},
        color={170,0,0},
        thickness=0.5));
    connect(C_l.q_in, R_lt.q_in) annotation (Line(
        points={{-44,30},{-44,60},{-40,60}},
        color={0,0,127},
        thickness=0.5));
    connect(totalAirFlow.q_in, R_ml.q_out) annotation (Line(
        points={{-64,60},{-66,60}},
        color={0,0,127},
        thickness=0.5));
    connect(totalAirFlow.q_out, R_lt.q_in) annotation (Line(
        points={{-44,60},{-40,60}},
        color={0,0,127},
        thickness=0.5));
    connect(R_bA.q_out, V_A_measure.q_in) annotation (Line(
        points={{60,60},{70,60}},
        color={0,0,127},
        thickness=0.5));
    connect(pulmonaryMuscles.q_in, chestWall.q_out) annotation (Line(
        points={{30,-30},{30,-30},{30,-30},{30,-30},{30,-20},{30,-20},{30,-20},
            {30,-20}},
        color={0,0,127},
        thickness=0.5));
    connect(C_tr.q_out, chestWall.q_in) annotation (Line(
        points={{-10,10},{-10,0},{30,0}},
        color={0,0,127},
        thickness=0.5));
    connect(C_b.q_out, chestWall.q_in) annotation (Line(
        points={{30,10},{30,0}},
        color={0,0,127},
        thickness=0.5));
    connect(C_b.q_in, R_tb.q_out) annotation (Line(
        points={{30,30},{30,37.5},{30,37.5},{30,45},{30,45},{30,60},{25,60},{25,
            60},{20,60}},
        color={0,0,127},
        thickness=0.5));
    connect(C_tr.q_in, R_lt.q_out) annotation (Line(
        points={{-10,30},{-10,60},{-20,60}},
        color={0,0,127},
        thickness=0.5));
    connect(R_tb.q_out, R_bA.q_in) annotation (Line(
        points={{20,60},{40,60}},
        color={0,0,127},
        thickness=0.5));
    connect(R_lt.q_out, R_tb.q_in) annotation (Line(
        points={{-20,60},{0,60}},
        color={0,0,127},
        thickness=0.5));
    connect(atmos_pressure.y, unlimitedVolume.pressure) annotation (Line(points={{-89.878,
            -86.6202},{-89.878,-84.3101},{-90,-84.3101},{-90,-80}},
          color={0,0,127}));
    connect(unlimitedVolume.y, R_ml.q_in) annotation (Line(
        points={{-90,-60},{-90,60},{-86,60}},
        color={0,0,0},
        thickness=1));
    connect(unlimitedVolume.y, pulmonaryMuscles.q_out) annotation (Line(
        points={{-90,-60},{-90,-56},{30,-56},{30,-50}},
        color={0,0,0},
        thickness=1));
    connect(C_l.q_out, pulmonaryMuscles.q_out) annotation (Line(
        points={{-44,10},{-44,-56},{30,-56},{30,-50}},
        color={0,0,0},
        thickness=1));
    annotation (Icon(coordinateSystem(initialScale=0.1), graphics={
          Bitmap(
            origin={51,69},
            extent={{-31,31},{49,-41}},
            imageSource=
                "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"),
          Text(
            origin={0,120},
            lineColor={0,0,255},
            extent={{-100,20},{100,-20}},
            textString="%name"),
          Bitmap(
            origin={-10,10},
            extent={{90,-90},{-70,70}},
            imageSource=
                "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")}));
  end LungMechanics;

  model LungGasTrans
    parameter Real m3PerMole=24e-3;
    parameter Physiolibrary.Types.Fraction deadspaceFracStart;
    parameter Physiolibrary.Types.Fraction alveoliFracStart;
    SemestralProjectDoloi_2017.GasExchangeTransport.Components.Stream out2dead
      annotation (Placement(visible=true, transformation(
          origin={-30,0},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    SemestralProjectDoloi_2017.GasExchangeTransport.Components.FracFlowSource
      outerFracFlow annotation (Placement(visible=true, transformation(
          origin={-60,0},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Physiolibrary.Types.BusConnector lungMech_bus annotation (Placement(
        visible=true,
        transformation(
          origin={15,51},
          extent={{-21,-21},{21,21}},
          rotation=0),
        iconTransformation(
          origin={0,-100},
          extent={{-20,-20},{20,20}},
          rotation=0)));
    SemestralProjectDoloi_2017.GasExchangeTransport.Components.Substance
      deadspace(gasFracStart(displayUnit="1") = deadspaceFracStart) annotation (
       Placement(visible=true, transformation(
          origin={0,-4},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    SemestralProjectDoloi_2017.GasExchangeTransport.Components.Substance
      alveoli(gasFracStart(displayUnit="1") = alveoliFracStart) annotation (
        Placement(visible=true, transformation(
          origin={60,-4},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    SemestralProjectDoloi_2017.GasExchangeTransport.Components.Stream
      dead2alveoli annotation (Placement(visible=true, transformation(
          origin={30,0},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Physiolibrary.Chemical.Sources.UnlimitedSolutionStorage
      unlimitedSolutionStorage(Conc(displayUnit="mol/m3"))
      annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
    Physiolibrary.Chemical.Components.Substance subs_dead(useNormalizedVolume=
          false, solute_start(displayUnit="mmol") = 0.04)
      annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
    Physiolibrary.Chemical.Components.Stream tracheaStream(useSolutionFlowInput=
         true)
      annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
    Physiolibrary.Chemical.Sensors.ConcentrationMeasure concentrationMeasure1
      annotation (Placement(transformation(extent={{-88,-20},{-68,-40}})));
    Modelica.Blocks.Math.Gain gain(k=1/m3PerMole) annotation (Placement(
          transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-79,-9})));
    Physiolibrary.Chemical.Components.Stream bronchiolyStream(
        useSolutionFlowInput=true)
      annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
    Physiolibrary.Chemical.Components.Substance subs_alveoli(
        useNormalizedVolume=false, solute_start(displayUnit="mmol") = 0.02)
      annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
    Physiolibrary.Chemical.Sensors.MolarFlowMeasure concentrationMeasure2
      annotation (Placement(transformation(extent={{-74,-60},{-54,-40}})));
    Modelica.Blocks.Continuous.Integrator gain1(k=1/m3PerMole) annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=270,
          origin={-65,-79})));
    Physiolibrary.Chemical.Sensors.ConcentrationMeasure concentrationMeasure3
      annotation (Placement(transformation(extent={{80,-64},{100,-84}})));
    Modelica.Blocks.Math.Gain alvFrac(k=1/m3PerMole) annotation (Placement(
          transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={109,-25})));
    Physiolibrary.Chemical.Sensors.ConcentrationMeasure concentrationMeasure4
      annotation (Placement(transformation(extent={{28,-76},{48,-96}})));
    Modelica.Blocks.Math.Gain deadFrac(k=1/m3PerMole) annotation (Placement(
          transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={49,-69})));
  equation
    connect(dead2alveoli.volumeFlow, lungMech_bus.alveolarFlow) annotation (
        Line(
        points={{30,6},{30,6},{30,40},{20,40},{20,51},{15,51}},
        color={0,85,0},
        thickness=0.5));
    connect(dead2alveoli.q_out, alveoli.q_in) annotation (Line(
        points={{40,0},{60,0},{60,0},{60,0}},
        color={0,0,127},
        thickness=0.5));
    connect(deadspace.q_in, dead2alveoli.q_in) annotation (Line(
        points={{0,0},{20,0},{20,0},{20,0}},
        color={0,0,127},
        thickness=0.5));
    connect(deadspace.volume, lungMech_bus.volumeDeadspace) annotation (Line(
        points={{0,6},{0,40},{10,40},{10,51},{15,51}},
        color={0,85,0},
        thickness=0.5));
    connect(alveoli.volume, lungMech_bus.volumeAlveoli) annotation (Line(
        points={{60,6},{60,51},{15,51}},
        color={0,85,0},
        thickness=0.5));
    connect(out2dead.volumeFlow, lungMech_bus.totalFlow) annotation (Line(
        points={{-30,6},{-30,51},{15,51}},
        color={0,85,0},
        thickness=0.5));
    connect(outerFracFlow.q_out, out2dead.q_in) annotation (Line(
        points={{-50,0},{-40,0},{-40,0},{-40,0}},
        color={0,0,127},
        thickness=0.5));
    connect(out2dead.q_out, deadspace.q_in) annotation (Line(
        points={{-20,0},{0,0}},
        color={0,0,127},
        thickness=0.5));
    connect(tracheaStream.q_out, subs_dead.q_out) annotation (Line(
        points={{-30,-50},{-10,-50}},
        color={107,45,134},
        thickness=1));
    connect(tracheaStream.solutionFlow, lungMech_bus.totalFlow) annotation (
        Line(points={{-40,-43},{-40,54},{15,54},{15,51}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(subs_dead.solutionVolume, lungMech_bus.volumeDeadspace) annotation (
       Line(points={{-14,-46},{-14,46},{15,46},{15,51}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(concentrationMeasure1.q_in, unlimitedSolutionStorage.q_out)
      annotation (Line(
        points={{-78,-30},{-78,-50},{-80,-50}},
        color={107,45,134},
        thickness=1));
    connect(gain.u, concentrationMeasure1.concentration) annotation (Line(
          points={{-79,-17.4},{-83.5,-17.4},{-83.5,-22},{-78,-22}}, color={0,0,
            127}));
    connect(gain.y, outerFracFlow.fractionIn) annotation (Line(points={{-79,
            -1.3},{-79.5,-1.3},{-79.5,0},{-70,0}}, color={0,0,127}));
    connect(subs_dead.q_out, bronchiolyStream.q_in) annotation (Line(
        points={{-10,-50},{20,-50}},
        color={107,45,134},
        thickness=1));
    connect(bronchiolyStream.q_out, subs_alveoli.q_out) annotation (Line(
        points={{40,-50},{70,-50}},
        color={107,45,134},
        thickness=1));
    connect(subs_alveoli.solutionVolume, lungMech_bus.volumeAlveoli)
      annotation (Line(points={{66,-46},{66,51},{15,51}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(bronchiolyStream.solutionFlow, lungMech_bus.alveolarFlow)
      annotation (Line(points={{30,-43},{30,51},{15,51}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(unlimitedSolutionStorage.q_out, concentrationMeasure2.q_in)
      annotation (Line(
        points={{-80,-50},{-74,-50}},
        color={107,45,134},
        thickness=1));
    connect(tracheaStream.q_in, concentrationMeasure2.q_out) annotation (Line(
        points={{-50,-50},{-54,-50}},
        color={107,45,134},
        thickness=1));
    connect(gain1.u, concentrationMeasure2.molarFlowRate) annotation (Line(
          points={{-65,-70.6},{-65,-65.3},{-64,-65.3},{-64,-58}}, color={0,0,
            127}));
    connect(concentrationMeasure3.concentration, alvFrac.u) annotation (Line(
          points={{90,-66},{90,-36},{109,-36},{109,-33.4}}, color={0,0,127}));
    connect(subs_alveoli.q_out, concentrationMeasure3.q_in) annotation (Line(
        points={{70,-50},{90,-50},{90,-74}},
        color={107,45,134},
        thickness=1));
    connect(concentrationMeasure4.concentration, deadFrac.u) annotation (Line(
          points={{38,-78},{38,-86},{49,-86},{49,-77.4}}, color={0,0,127}));
    connect(concentrationMeasure4.q_in, bronchiolyStream.q_in) annotation (Line(
        points={{38,-86},{20,-86},{20,-50}},
        color={107,45,134},
        thickness=1));
    annotation (Icon(graphics={
          Text(
            origin={80,120},
            lineColor={0,0,255},
            extent={{-100,20},{100,-20}},
            textString="%name"),
          Bitmap(
            origin={0,10},
            extent={{80,-90},{-80,70}},
            imageSource=
                "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"),
          Bitmap(
            origin={61,70},
            extent={{-39,30},{39,-30}},
            imageSource=
                "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")},
          coordinateSystem(initialScale=0.1)), Documentation(info=
            "<html><head></head><body>This represents partially equation A42,A44 (or A43,A45).<div><br></div></body></html>"));
  end LungGasTrans;

  package OriginalDoLoi
    model LungGasTrans_orig
      parameter Physiolibrary.Types.Fraction deadspaceFracStart;
      parameter Physiolibrary.Types.Fraction alveoliFracStart;
      SemestralProjectDoloi_2017.GasExchangeTransport.Components.Stream
        out2dead annotation (Placement(visible=true, transformation(
            origin={-30,0},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      SemestralProjectDoloi_2017.GasExchangeTransport.Components.FracFlowSource
        outerFracFlow annotation (Placement(visible=true, transformation(
            origin={-60,0},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Physiolibrary.Types.BusConnector lungMech_bus annotation (Placement(
          visible=true,
          transformation(
            origin={15,51},
            extent={{-21,-21},{21,21}},
            rotation=0),
          iconTransformation(
            origin={0,-100},
            extent={{-20,-20},{20,20}},
            rotation=0)));
      Physiolibrary.Types.RealIO.FractionInput outerGasFrac annotation (
          Placement(
          visible=true,
          transformation(
            origin={-108,0},
            extent={{-20,-20},{20,20}},
            rotation=0),
          iconTransformation(
            origin={-100,0},
            extent={{-20,-20},{20,20}},
            rotation=0)));
      SemestralProjectDoloi_2017.GasExchangeTransport.Components.Substance
        deadspace(gasFracStart(displayUnit="1") = deadspaceFracStart)
        annotation (Placement(visible=true, transformation(
            origin={0,-4},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      SemestralProjectDoloi_2017.GasExchangeTransport.Components.Substance
        alveoli(gasFracStart(displayUnit="1") = alveoliFracStart) annotation (
          Placement(visible=true, transformation(
            origin={60,-4},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      SemestralProjectDoloi_2017.GasExchangeTransport.Interfaces.FractionFlowPort_b
        q_out annotation (Placement(
          visible=true,
          transformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0),
          iconTransformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      SemestralProjectDoloi_2017.GasExchangeTransport.Components.Stream
        dead2alveoli annotation (Placement(visible=true, transformation(
            origin={30,0},
            extent={{-10,-10},{10,10}},
            rotation=0)));
    equation
      connect(dead2alveoli.volumeFlow, lungMech_bus.alveolarFlow) annotation (
          Line(
          points={{30,6},{30,6},{30,40},{20,40},{20,51},{15,51}},
          color={0,85,0},
          thickness=0.5));
      connect(dead2alveoli.q_out, alveoli.q_in) annotation (Line(
          points={{40,0},{60,0},{60,0},{60,0}},
          color={0,0,127},
          thickness=0.5));
      connect(deadspace.q_in, dead2alveoli.q_in) annotation (Line(
          points={{0,0},{20,0},{20,0},{20,0}},
          color={0,0,127},
          thickness=0.5));
      connect(deadspace.volume, lungMech_bus.volumeDeadspace) annotation (Line(
          points={{0,6},{0,40},{10,40},{10,51},{15,51}},
          color={0,85,0},
          thickness=0.5));
      connect(alveoli.volume, lungMech_bus.volumeAlveoli) annotation (Line(
          points={{60,6},{60,51},{15,51}},
          color={0,85,0},
          thickness=0.5));
      connect(out2dead.volumeFlow, lungMech_bus.totalFlow) annotation (Line(
          points={{-30,6},{-30,51},{15,51}},
          color={0,85,0},
          thickness=0.5));
      connect(q_out, alveoli.q_in) annotation (Line(
          points={{100,0},{60,0}},
          color={0,0,127},
          thickness=0.5));
      connect(outerFracFlow.q_out, out2dead.q_in) annotation (Line(
          points={{-50,0},{-40,0},{-40,0},{-40,0}},
          color={0,0,127},
          thickness=0.5));
      connect(out2dead.q_out, deadspace.q_in) annotation (Line(
          points={{-20,0},{0,0}},
          color={0,0,127},
          thickness=0.5));
      connect(outerGasFrac, outerFracFlow.fractionIn) annotation (Line(
          points={{-108,0},{-70,0}},
          color={0,85,0},
          thickness=0.5));
      annotation (Icon(graphics={
            Text(
              origin={80,120},
              lineColor={0,0,255},
              extent={{-100,20},{100,-20}},
              textString="%name"),
            Bitmap(
              origin={0,-10},
              extent={{-80,90},{80,-70}},
              imageSource=
                  "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"),
            Bitmap(
              origin={61,70},
              extent={{-39,30},{39,-30}},
              imageSource=
                  "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")},
            coordinateSystem(initialScale=0.1)), Documentation(info=
              "<html><head></head><body>This represents partially equation A42,A44 (or A43,A45).<div><br></div></body></html>"));
    end LungGasTrans_orig;

    model LungMechanics_bckp
      Physiolibrary.Hydraulic.Components.Resistor R_ml(Resistance(displayUnit=
              "(Pa.s)/m3") = 100125.9, cond(displayUnit="m3/(Pa.s)"))
        annotation (Placement(visible=true, transformation(
            origin={-76,60},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Physiolibrary.Hydraulic.Components.Resistor R_lt(Resistance(displayUnit=
              "(Pa.s)/m3") = 33038.6039, cond(displayUnit="m3/(Pa.s)"))
        annotation (Placement(visible=true, transformation(
            origin={-30,60},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Physiolibrary.Hydraulic.Components.Resistor R_tb(Resistance(displayUnit=
              "(Pa.s)/m3") = 30037.76895, cond(displayUnit="m3/(Pa.s)"))
        annotation (Placement(visible=true, transformation(
            origin={10,60},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Physiolibrary.Hydraulic.Components.Resistor R_bA(Resistance(displayUnit=
              "(Pa.s)/m3") = 8012.03305, cond(displayUnit="m3/(Pa.s)"))
        annotation (Placement(visible=true, transformation(
            origin={50,60},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Airway C_tr(
        c(displayUnit="ml/mmHg") = 2.42692459e-08,
        zero_press_vol(displayUnit="ml") = 6.63e-06,
        init_vol(displayUnit="ml") = 1.85706e-05) annotation (Placement(visible
            =true, transformation(
            origin={-10,20},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      Airway C_b(
        c(displayUnit="ml/mmHg") = 1.3358282e-07,
        zero_press_vol(displayUnit="ml") = 3.44e-05,
        init_vol(displayUnit="ml") = 0.000100159) annotation (Placement(visible
            =true, transformation(
            origin={30,20},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      Physiolibrary.Types.Constants.PressureConst atmos_pressure(k(displayUnit=
              "Pa") = 0) annotation (Placement(visible=true, transformation(
            origin={-89.878,-93.7729},
            extent={{-5.72212,-5.82707},{5.72212,5.82707}},
            rotation=90)));
      SemestralProjectDoloi_2017.LungMechanics.Subsystems.Pmus pulmonaryMuscles
        annotation (Placement(visible=true, transformation(
            origin={30,-40},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      Airway C_A(
        c(displayUnit="m3/Pa") = 2.0394e-6,
        init_vol(displayUnit="m3") = 0.00226696,
        zero_press_vol(displayUnit="m3") = 0.00126288) annotation (Placement(
            visible=true, transformation(
            origin={70,20},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      SemestralProjectDoloi_2017.LungMechanics.Components.ElasticMembrane
        chestWall(c(displayUnit="m3/Pa") = 2.4932e-06, init_press(displayUnit=
              "Pa") = -490.333) annotation (Placement(visible=true,
            transformation(
            origin={30,-10},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      Physiolibrary.Hydraulic.Sensors.FlowMeasure V_A_measure annotation (
          Placement(visible=true, transformation(
            origin={70,50},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      Physiolibrary.Types.BusConnector busConnector1 annotation (Placement(
          visible=true,
          transformation(
            origin={60,-80},
            extent={{-20,-20},{20,20}},
            rotation=0),
          iconTransformation(
            origin={100,0},
            extent={{-20,-20},{20,20}},
            rotation=-90)));
      Physiolibrary.Hydraulic.Sensors.FlowMeasure totalAirFlow annotation (
          Placement(visible=true, transformation(
            origin={-54,60},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Airway C_l(
        c(displayUnit="l/mmHg") = 1.29503959e-08,
        zero_press_vol(displayUnit="ml") = 3.44e-05,
        init_vol(displayUnit="ml") = 4.07678e-05) annotation (Placement(visible
            =true, transformation(
            origin={-44,20},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      Modelica.Blocks.Math.Add3 total_deadspace_vol annotation (Placement(
            visible=true, transformation(
            origin={-66,-20},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      Physiolibrary.Types.TorsoBusConnector RespiratoryControl_Bus annotation (
          Placement(
          visible=true,
          transformation(
            origin={-20,-100},
            extent={{-20,-20},{20,20}},
            rotation=0),
          iconTransformation(
            origin={-100,0},
            extent={{-20,-20},{20,20}},
            rotation=-90)));
      Physiolibrary.Hydraulic.Sources.UnlimitedVolume unlimitedVolume(
          usePressureInput=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,-70})));
    equation
      connect(totalAirFlow.volumeFlow, busConnector1.totalFlow) annotation (
          Line(
          points={{-54,72},{92,72},{92,-80},{60,-80}},
          color={170,0,0},
          thickness=0.5));
      connect(total_deadspace_vol.y, busConnector1.volumeDeadspace) annotation (
         Line(
          points={{-66,-31},{-66,-80},{60,-80}},
          color={170,0,0},
          thickness=0.5));
      connect(V_A_measure.volumeFlow, busConnector1.alveolarFlow) annotation (
          Line(
          points={{82,50},{88,50},{88,-60},{63,-60},{63,-80},{60,-80}},
          color={170,0,0},
          thickness=0.5));
      connect(C_A.volume, busConnector1.volumeAlveoli) annotation (Line(
          points={{60,16},{54,16},{54,-80},{60,-80}},
          color={170,0,0},
          thickness=0.5));
      connect(pulmonaryMuscles.Pmus_min, RespiratoryControl_Bus.Pmus_min)
        annotation (Line(
          points={{20,-46},{-14,-46},{-14,-100},{-20,-100}},
          color={0,85,0},
          thickness=0.5));
      connect(pulmonaryMuscles.RR, RespiratoryControl_Bus.RR) annotation (Line(
          points={{20,-34},{-26,-34},{-26,-100},{-20,-100}},
          color={0,85,0},
          thickness=0.5));
      connect(C_A.q_out, chestWall.q_in) annotation (Line(
          points={{70,10},{70,0},{30,0}},
          color={0,0,127},
          thickness=0.5));
      connect(V_A_measure.q_out, C_A.q_in) annotation (Line(
          points={{70,40},{70,30}},
          color={0,0,127},
          thickness=0.5));
      connect(total_deadspace_vol.u3, C_l.volume) annotation (Line(
          points={{-74,-8},{-74,16},{-54,16}},
          color={170,0,0},
          thickness=0.5));
      connect(total_deadspace_vol.u1, C_b.volume) annotation (Line(
          points={{-58,-8},{-58,-2},{-58,-2},{-58,4},{10,4},{10,16},{20,16}},
          color={170,0,0},
          thickness=0.5));
      connect(C_tr.volume, total_deadspace_vol.u2) annotation (Line(
          points={{-20,16},{-30,16},{-30,8},{-66,8},{-66,-8}},
          color={170,0,0},
          thickness=0.5));
      connect(C_l.q_in, R_lt.q_in) annotation (Line(
          points={{-44,30},{-44,60},{-40,60}},
          color={0,0,127},
          thickness=0.5));
      connect(totalAirFlow.q_in, R_ml.q_out) annotation (Line(
          points={{-64,60},{-66,60}},
          color={0,0,127},
          thickness=0.5));
      connect(totalAirFlow.q_out, R_lt.q_in) annotation (Line(
          points={{-44,60},{-40,60}},
          color={0,0,127},
          thickness=0.5));
      connect(R_bA.q_out, V_A_measure.q_in) annotation (Line(
          points={{60,60},{70,60}},
          color={0,0,127},
          thickness=0.5));
      connect(pulmonaryMuscles.q_in, chestWall.q_out) annotation (Line(
          points={{30,-30},{30,-30},{30,-30},{30,-30},{30,-20},{30,-20},{30,-20},
              {30,-20}},
          color={0,0,127},
          thickness=0.5));
      connect(C_tr.q_out, chestWall.q_in) annotation (Line(
          points={{-10,10},{-10,0},{30,0}},
          color={0,0,127},
          thickness=0.5));
      connect(C_b.q_out, chestWall.q_in) annotation (Line(
          points={{30,10},{30,0}},
          color={0,0,127},
          thickness=0.5));
      connect(C_b.q_in, R_tb.q_out) annotation (Line(
          points={{30,30},{30,37.5},{30,37.5},{30,45},{30,45},{30,60},{25,60},{
              25,60},{20,60}},
          color={0,0,127},
          thickness=0.5));
      connect(C_tr.q_in, R_lt.q_out) annotation (Line(
          points={{-10,30},{-10,60},{-20,60}},
          color={0,0,127},
          thickness=0.5));
      connect(R_tb.q_out, R_bA.q_in) annotation (Line(
          points={{20,60},{40,60}},
          color={0,0,127},
          thickness=0.5));
      connect(R_lt.q_out, R_tb.q_in) annotation (Line(
          points={{-20,60},{0,60}},
          color={0,0,127},
          thickness=0.5));
      connect(atmos_pressure.y, unlimitedVolume.pressure) annotation (Line(
            points={{-89.878,-86.6202},{-89.878,-84.3101},{-90,-84.3101},{-90,
              -80}}, color={0,0,127}));
      connect(unlimitedVolume.y, R_ml.q_in) annotation (Line(
          points={{-90,-60},{-90,60},{-86,60}},
          color={0,0,0},
          thickness=1));
      connect(unlimitedVolume.y, pulmonaryMuscles.q_out) annotation (Line(
          points={{-90,-60},{-90,-56},{30,-56},{30,-50}},
          color={0,0,0},
          thickness=1));
      connect(C_l.q_out, pulmonaryMuscles.q_out) annotation (Line(
          points={{-44,10},{-44,-56},{30,-56},{30,-50}},
          color={0,0,0},
          thickness=1));
      annotation (Icon(coordinateSystem(initialScale=0.1), graphics={
            Bitmap(
              origin={51,69},
              extent={{-31,31},{49,-41}},
              imageSource=
                  "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"),
            Text(
              origin={0,120},
              lineColor={0,0,255},
              extent={{-100,20},{100,-20}},
              textString="%name"),
            Bitmap(
              origin={-10,10},
              extent={{90,-90},{-70,70}},
              imageSource=
                  "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")}));
    end LungMechanics_bckp;

    model GasFrac2PartPress_ "eq: A52,A53"
      Physiolibrary.Types.RealIO.FractionInput gasFrac annotation (Placement(
          visible=true,
          transformation(
            origin={-84,10},
            extent={{-20,-20},{20,20}},
            rotation=0),
          iconTransformation(
            origin={-100,0},
            extent={{-20,-20},{20,20}},
            rotation=0)));
      Physiolibrary.Types.RealIO.PressureOutput partPress annotation (Placement(
          visible=true,
          transformation(
            origin={68,0},
            extent={{-10,-10},{10,10}},
            rotation=0),
          iconTransformation(
            origin={100,0},
            extent={{-20,-20},{20,20}},
            rotation=0)));
      parameter Physiolibrary.Types.Pressure P_atm(displayUnit="Pa") = 101323.2
        "atmospheric pressure";
      parameter Physiolibrary.Types.Pressure P_ws(displayUnit="Pa") = 6266.04
        "pressure of water vapour";
    equation
      partPress = gasFrac*(P_atm - P_ws)
        "convert gas fraction in medium to partial pressure";
      annotation (Icon(graphics={
            Rectangle(
              origin={60,0},
              fillColor={0,170,255},
              fillPattern=FillPattern.Solid,
              extent={{-40,40},{40,-40}}),
            Line(
              origin={0.93,-0.31},
              points={{-20,0},{20,0}},
              thickness=1,
              arrow={Arrow.None,Arrow.Filled},
              arrowSize=5),
            Ellipse(
              origin={40,20},
              lineColor={170,0,255},
              fillColor={170,0,255},
              fillPattern=FillPattern.Solid,
              extent={{-2,2},{2,-2}},
              endAngle=360),
            Ellipse(
              origin={50,30},
              lineColor={170,0,255},
              fillColor={170,0,255},
              fillPattern=FillPattern.Solid,
              extent={{-2,2},{2,-2}},
              endAngle=360),
            Ellipse(
              origin={68,-24},
              lineColor={170,0,255},
              fillColor={170,0,255},
              fillPattern=FillPattern.Solid,
              extent={{-2,2},{2,-2}},
              endAngle=360),
            Ellipse(
              origin={50,-10},
              lineColor={170,0,255},
              fillColor={170,0,255},
              fillPattern=FillPattern.Solid,
              extent={{-2,2},{2,-2}},
              endAngle=360),
            Ellipse(
              origin={68,12},
              lineColor={170,0,255},
              fillColor={170,0,255},
              fillPattern=FillPattern.Solid,
              extent={{-2,2},{2,-2}},
              endAngle=360),
            Ellipse(
              origin={30,-8},
              lineColor={170,0,255},
              fillColor={170,0,255},
              fillPattern=FillPattern.Solid,
              extent={{-2,2},{2,-2}},
              endAngle=360),
            Rectangle(
              origin={-60,0},
              fillColor={0,170,255},
              fillPattern=FillPattern.Solid,
              extent={{-40,40},{40,-40}}),
            Text(
              origin={-27,-69},
              lineColor={0,0,255},
              extent={{-53,9},{107,-51}},
              textString="%name"),
            Line(
              origin={-53.3971,2.40442},
              points={{12,23},{-12,-21},{-12,-21}},
              thickness=1),
            Ellipse(
              origin={-59,21},
              fillPattern=FillPattern.Solid,
              extent={{-5,5},{1,-1}},
              endAngle=360),
            Ellipse(
              origin={-43,-19},
              fillPattern=FillPattern.Solid,
              extent={{-5,5},{1,-1}},
              endAngle=360)}, coordinateSystem(initialScale=0.1)),
          Documentation(info="<html><head></head><body>
<p><span style=\" font-family:'Courier New'; font-size:12pt; color:#008b00;\">Compute partial pressure of gas from its fraction in medium, P_atm and P_ws. </span></p></body></html>"));
    end GasFrac2PartPress_;
  end OriginalDoLoi;

  model TestGT
    LungGasTrans lungGasTrans(deadspaceFracStart=0.01, alveoliFracStart=0.01)
      annotation (Placement(transformation(extent={{8,52},{28,72}})));
    LungMechanics lungMechanics
      annotation (Placement(transformation(extent={{-28,42},{-8,62}})));
    Modelica.Blocks.Sources.Constant RR(k=12) annotation (Placement(visible=
            true, transformation(
          origin={-88,52},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Physiolibrary.Types.Constants.PressureConst P_mus_min(k(displayUnit="Pa")=
           -490.333) annotation (Placement(visible=true, transformation(
          origin={-90,18},
          extent={{-4,-4},{4,4}},
          rotation=0)));
    Physiolibrary.Types.TorsoBusConnector RespiratoryControl_Bus annotation (
        Placement(
        visible=true,
        transformation(
          origin={-52,52},
          extent={{-20,-20},{20,20}},
          rotation=0),
        iconTransformation(
          origin={-100,0},
          extent={{-20,-20},{20,20}},
          rotation=-90)));
  equation
    connect(lungMechanics.RespiratoryControl_Bus, RespiratoryControl_Bus)
      annotation (Line(
        points={{-28,52},{-52,52}},
        color={129,194,194},
        thickness=1), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(RR.y, RespiratoryControl_Bus.RR) annotation (Line(points={{-77,52},
            {-52,52}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(P_mus_min.y, RespiratoryControl_Bus.Pmus_min) annotation (Line(
          points={{-85,18},{-52,18},{-52,52}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(lungGasTrans.lungMech_bus, lungMechanics.busConnector1) annotation (
       Line(
        points={{18,52},{-8,52}},
        color={0,0,255},
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TestGT;

  model AlveolarGasExchange
    import Physiolibrary.Types.*;
    constant Real mmHg2Pa=133.32;
    Physiolibrary.Types.RealIO.FractionInput Fa_otherGas
      "the other gas - CO2 for O2 and o2 for CO2" annotation (Placement(
          transformation(extent={{-120,52},{-80,92}}), iconTransformation(
            extent={{-120,52},{-80,92}})));
    parameter Concentration Csat=86.11
      "mmol/l parameter of the dissociation curve";


    parameter Real h=1.819 "- parameter of the dissociation curve";
    Physiolibrary.Types.RealIO.ConcentrationOutput Cpp=Csat*(Xpp^(1/h))/(1 + (
        Xpp^(1/h))) "mmol/l concentration of the gas" annotation (Placement(
          transformation(extent={{60,-20},{100,20}}), iconTransformation(extent=
             {{60,-20},{100,20}})));

    parameter Real alpha(unit="Pa-1") "parameter of the dissociation curve";
    parameter Real beta(unit="Pa-1") "parameter of the dissociation curve";
    parameter Real k(unit="Pa") "parameter of the dissociation curve";

    Real Xpp=Ppp*(1 + beta*Ppp_gas2)/(k*(1 + alpha*Ppp_gas2));
    Pressure Ppp=Pa "Partial pressure of gas in pulmonary capilaries";


    parameter Pressure Patm=760*mmHg2Pa "Pa atmospheric pressure";
    parameter Pressure Pws=47*mmHg2Pa "Pa pressure of water vapor in alveoles";
    Pressure Pa=Fa*(Patm - Pws) "Partial pressure of the gas";
    Pressure Ppp_gas2=Fa_otherGas*(Patm - Pws)
      "Partial pressure of the other gas for the dissociation curve";

    Physiolibrary.Types.RealIO.FractionInput Fa
      "- fraction of gas in the alveoli" annotation (Placement(transformation(
            extent={{-120,-80},{-80,-40}}), iconTransformation(extent={{-120,-80},
              {-80,-40}})));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end AlveolarGasExchange;

  model TestAGE
    SemestralProjectDoloi_2017.GasExchangeTransport.Components.Dissociation
      diss_CO2(
      C_sat(displayUnit="mol/m3") = 86.11,
      K(displayUnit="Pa") = 25917.9,
      alpha=0.0004193595,
      beta=0.0002441451,
      h=1.819) annotation (Placement(visible=true, transformation(
          origin={14,40},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    OriginalDoLoi.GasFrac2PartPress_ frac2press_CO2(P_atm(displayUnit="Pa"),
        P_ws(displayUnit="Pa")) annotation (Placement(visible=true,
          transformation(
          origin={-50,44},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    OriginalDoLoi.GasFrac2PartPress_ frac2press_O2(P_atm(displayUnit="Pa"),
        P_ws(displayUnit="Pa")) annotation (Placement(visible=true,
          transformation(
          origin={-70,-30},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    AlveolarGasExchange alveolarGasExchange(
      Csat=86.11,
      k=25917.9,
      alpha=0.0004193595,
      beta=0.0002441451,
      h=1.819) annotation (Placement(transformation(extent={{0,-20},{20,0}})));
    Physiolibrary.Types.Constants.FractionConst fraction(k=0.05)
      annotation (Placement(transformation(extent={{-100,40},{-92,48}})));
    Physiolibrary.Types.Constants.FractionConst fraction1(k=0.16)
      annotation (Placement(transformation(extent={{-100,-34},{-92,-26}})));
  equation
    connect(diss_CO2.P_pp, frac2press_CO2.partPress)
      annotation (Line(points={{4,44},{-40,44}}, color={0,0,127}));
    connect(fraction.y, frac2press_CO2.gasFrac)
      annotation (Line(points={{-91,44},{-60,44}}, color={0,0,127}));
    connect(fraction1.y, frac2press_O2.gasFrac)
      annotation (Line(points={{-91,-30},{-80,-30}}, color={0,0,127}));
    connect(diss_CO2.P_pp_ext, frac2press_O2.partPress)
      annotation (Line(points={{4,36},{-60,36},{-60,-30}}, color={0,0,127}));
    connect(alveolarGasExchange.Fa, fraction.y)
      annotation (Line(points={{0,-16},{-91,-16},{-91,44}}, color={0,0,127}));
    connect(alveolarGasExchange.Ppp_gas2, frac2press_O2.partPress) annotation (
        Line(points={{0,-2.8},{-30,-2.8},{-30,-2},{-60,-2},{-60,-30}}, color={0,
            0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TestAGE;

  model CirculationGas
    Physiolibrary.Chemical.Components.Substance arteries(useNormalizedVolume=
          true, solute_start=0.008)
      annotation (Placement(transformation(extent={{20,-60},{0,-40}})));
    Physiolibrary.Chemical.Components.Substance veins(solute_start=0.025)
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
    Physiolibrary.Chemical.Components.Stream arterialStream(SolutionFlow=
          bloodFlow)
      annotation (Placement(transformation(extent={{0,-78},{-20,-58}})));
    Physiolibrary.Chemical.Components.Stream VenousStream(useSolutionFlowInput=
          false, SolutionFlow=bloodFlow) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-30,-20})));
    Physiolibrary.Chemical.Sources.UnlimitedSolutionStorage
      unlimitedSolutionStorage annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,10})));
    Physiolibrary.Chemical.Components.Stream LungStream(SolutionFlow=bloodFlow)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={10,-20})));
    parameter Real bloodFlow=5/60/1000;
    constant Real m3PerMole=25.45e-3 "molar volume of the gas at 1 atm and 37 degC";
    constant Real mmHg = 133.32;
    Physiolibrary.Chemical.Sources.UnlimitedSolutePump unlimitedSolutePump(
        SoluteFlow=0.00035) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-30,-90})));
    AlveolarGasExchange CO2_alveolarGasExchange(
      Csat=86.11,
      k=25917.9,
      alpha=0.0004193595,
      beta=0.0002441451,
      h=1.819) annotation (Placement(transformation(extent={{60,40},{40,20}})));
    Physiolibrary.Chemical.Sources.UnlimitedSolutionStorage
      pulmonaryConcentration(useConcentrationInput=true) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={10,10})));
    Physiolibrary.Types.Constants.FractionConst fracO2(k=0.16) annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={78,14})));
    Physiolibrary.Chemical.Sensors.ConcentrationMeasure venousConc
      annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
    Physiolibrary.Chemical.Sensors.ConcentrationMeasure arterialConc
      annotation (Placement(transformation(extent={{22,-20},{42,0}})));
    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{40,-40},{50,-30}})));
    Physiolibrary.Chemical.Components.Substance subs_dead(useNormalizedVolume=
          false, solute_start(displayUnit="mmol") = 0.04)
      annotation (Placement(transformation(extent={{-54,64},{-34,84}})));
    Physiolibrary.Chemical.Components.Stream tracheaStream(useSolutionFlowInput=
         true)
      annotation (Placement(transformation(extent={{-84,64},{-64,84}})));
    Physiolibrary.Chemical.Components.Stream bronchiolyStream(
        useSolutionFlowInput=true)
      annotation (Placement(transformation(extent={{-14,64},{6,84}})));
    Physiolibrary.Chemical.Components.Substance subs_alveoli(
        useNormalizedVolume=false, solute_start(displayUnit="mmol") = 1e-9)
      annotation (Placement(transformation(extent={{26,64},{46,84}})));
    Physiolibrary.Types.BusConnector lungMech_bus annotation (Placement(
        visible=true,
        transformation(
          origin={-21,105},
          extent={{-21,-21},{21,21}},
          rotation=0),
        iconTransformation(
          origin={0,-100},
          extent={{-20,-20},{20,20}},
          rotation=0)));
    Modelica.Blocks.Math.Gain alvFrac(k=m3PerMole)   annotation (Placement(
          transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={89,35})));
    Physiolibrary.Chemical.Sensors.ConcentrationMeasure concentrationMeasure3
      annotation (Placement(transformation(extent={{88,64},{108,84}})));
    Physiolibrary.Chemical.Sources.UnlimitedSolutionStorage concentrationDiff(
                                     Conc=4, useConcentrationInput=true)
                                    annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={63,-35})));
    Physiolibrary.Chemical.Components.Stream gasExhaleFlow(useSolutionFlowInput=
         false, SolutionFlow=bloodFlow) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={88,-34})));
    AlveolarGasExchange CO2_alveolarGasExchange1(
      Csat=86.11,
      k=194.4*mmHg,
      alpha=0.05591/mmHg,
      beta=0.0325/mmHg,
      h=1.819) annotation (Placement(transformation(extent={{60,14},{40,-6}})));
    AlveolarGasExchange CO2_alveolarGasExchange2(
      Csat=86.11,
      h=1.819,
      alpha=0.05591,
      beta=0.0325,
      k=194.4,
      Patm=760,
      Pws=47)  annotation (Placement(transformation(extent={{60,66},{40,46}})));
    Modelica.Blocks.Math.Gain alvFrac1(k=mmHg)       annotation (Placement(
          transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={23,55})));
    Physiolibrary.Chemical.Components.Substance subs_dead1(
                                                          useNormalizedVolume=
          false, solute_start(displayUnit="mmol") = 1e-09)
      annotation (Placement(transformation(extent={{-116,64},{-96,84}})));
    Physiolibrary.Types.Constants.VolumeConst   fracO1(k(displayUnit="l") =
        0.01)                                                  annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={-92,100})));
  equation
    connect(unlimitedSolutionStorage.q_out, VenousStream.q_out) annotation (
        Line(
        points={{-30,0},{-30,-10}},
        color={107,45,134},
        thickness=1));
    connect(VenousStream.q_in, veins.q_out) annotation (Line(
        points={{-30,-30},{-30,-50}},
        color={107,45,134},
        thickness=1));
    connect(veins.q_out, arterialStream.q_out) annotation (Line(
        points={{-30,-50},{-30,-68},{-20,-68}},
        color={107,45,134},
        thickness=1));
    connect(arterialStream.q_in, arteries.q_out) annotation (Line(
        points={{0,-68},{10,-68},{10,-50}},
        color={107,45,134},
        thickness=1));
    connect(LungStream.q_out, arteries.q_out) annotation (Line(
        points={{10,-30},{10,-50}},
        color={107,45,134},
        thickness=1));
    connect(unlimitedSolutePump.q_out, arterialStream.q_out) annotation (Line(
        points={{-30,-80},{-30,-68},{-20,-68}},
        color={107,45,134},
        thickness=1));
    connect(CO2_alveolarGasExchange.Cpp, pulmonaryConcentration.concentration)
      annotation (Line(points={{42,30},{10,30},{10,20}}, color={0,0,127}));
    connect(pulmonaryConcentration.q_out, LungStream.q_in) annotation (Line(
        points={{10,0},{10,-10}},
        color={107,45,134},
        thickness=1));
    connect(venousConc.q_in, VenousStream.q_in) annotation (Line(
        points={{-50,-30},{-30,-30}},
        color={107,45,134},
        thickness=1));
    connect(LungStream.q_in, arterialConc.q_in) annotation (Line(
        points={{10,-10},{32,-10}},
        color={107,45,134},
        thickness=1));
    connect(arterialConc.concentration, add.u1)
      annotation (Line(points={{32,-18},{32,-32},{39,-32}}, color={0,0,127}));
    connect(venousConc.concentration, add.u2)
      annotation (Line(points={{-50,-38},{39,-38}}, color={0,0,127}));
    connect(tracheaStream.q_out, subs_dead.q_out) annotation (Line(
        points={{-64,74},{-44,74}},
        color={107,45,134},
        thickness=1));
    connect(tracheaStream.solutionFlow, lungMech_bus.totalFlow) annotation (
        Line(points={{-74,81},{-74,104},{-21,104},{-21,105}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(subs_dead.solutionVolume, lungMech_bus.volumeDeadspace) annotation (
       Line(points={{-48,78},{-48,104},{-22,104},{-22,105},{-21,105}}, color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(subs_dead.q_out, bronchiolyStream.q_in) annotation (Line(
        points={{-44,74},{-14,74}},
        color={107,45,134},
        thickness=1));
    connect(bronchiolyStream.q_out, subs_alveoli.q_out) annotation (Line(
        points={{6,74},{36,74}},
        color={107,45,134},
        thickness=1));
    connect(subs_alveoli.solutionVolume, lungMech_bus.volumeAlveoli)
      annotation (Line(points={{32,78},{32,105},{-21,105}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(bronchiolyStream.solutionFlow, lungMech_bus.alveolarFlow)
      annotation (Line(points={{-4,81},{-4,105},{-21,105}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(concentrationMeasure3.concentration, alvFrac.u)
      annotation (Line(points={{98,66},{97.4,66},{97.4,35}}, color={0,0,127}));
    connect(subs_alveoli.q_out, concentrationMeasure3.q_in) annotation (Line(
        points={{36,74},{98,74}},
        color={107,45,134},
        thickness=1));
    connect(alvFrac.y, CO2_alveolarGasExchange.Fa) annotation (Line(points={{81.3,35},
            {65.65,35},{65.65,36},{60,36}},          color={0,0,127}));
    connect(concentrationDiff.q_out, gasExhaleFlow.q_in) annotation (Line(
        points={{68,-35},{68,-34},{78,-34}},
        color={107,45,134},
        thickness=1));
    connect(gasExhaleFlow.q_out, concentrationMeasure3.q_in) annotation (Line(
        points={{98,-34},{108,-34},{108,74},{98,74}},
        color={107,45,134},
        thickness=1));
    connect(CO2_alveolarGasExchange.Fa_otherGas, fracO2.y) annotation (Line(
          points={{60,22.8},{66,22.8},{66,22},{68,22},{68,14},{73,14}}, color={
            0,0,127}));
    connect(CO2_alveolarGasExchange1.Fa, alvFrac.y) annotation (Line(points={{60,10},
            {66,10},{66,35},{81.3,35}}, color={0,0,127}));
    connect(fracO2.y, CO2_alveolarGasExchange1.Fa_otherGas) annotation (Line(
          points={{73,14},{68,14},{68,-3.2},{60,-3.2}}, color={0,0,127}));
    connect(alvFrac1.u, CO2_alveolarGasExchange2.Cpp) annotation (Line(points={{31.4,
            55},{35.7,55},{35.7,56},{42,56}}, color={0,0,127}));
    connect(CO2_alveolarGasExchange2.Fa_otherGas, fracO2.y) annotation (Line(
          points={{60,48.8},{66,48.8},{66,14},{73,14}}, color={0,0,127}));
    connect(CO2_alveolarGasExchange2.Fa, alvFrac.y)
      annotation (Line(points={{60,62},{81.3,62},{81.3,35}}, color={0,0,127}));
    connect(add.y, concentrationDiff.concentration)
      annotation (Line(points={{50.5,-35},{58,-35}}, color={0,0,127}));
    connect(subs_dead1.q_out, tracheaStream.q_in) annotation (Line(
        points={{-106,74},{-84,74}},
        color={107,45,134},
        thickness=1));
    connect(fracO1.y, subs_dead1.solutionVolume) annotation (Line(points={{-97,
            100},{-110,100},{-110,78}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
              -100},{120,120}})), Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-140,-100},{120,120}})));
  end CirculationGas;

  model AlveolarGasExchangeSI
    import Physiolibrary.Types.*;
    constant Real mmHg2Pa=133.32;

    Physiolibrary.Types.RealIO.PressureInput Ppp_gas2
      "Partial pressure of the other gas for the dissociation curve"
      annotation (Placement(transformation(extent={{-120,52},{-80,92}}),
          iconTransformation(extent={{-120,52},{-80,92}})));
    parameter Concentration Csat=86.11
      "mmol/l parameter of the dissociation curve";

    parameter Real h=1.819 "- parameter of the dissociation curve";
    Physiolibrary.Types.RealIO.ConcentrationOutput Cpp=Csat*(Xpp^(1/h))/(1 + (
        Xpp^(1/h))) "mmol/l concentration of the gas" annotation (Placement(
          transformation(extent={{60,-20},{100,20}}), iconTransformation(extent=
             {{60,-20},{100,20}})));

    parameter Real alfa(unit="mmHg-1") "parameter of the dissociation curve";
    parameter Real beta(unit="mmHg-1") "parameter of the dissociation curve";
    parameter Real k(unit="mmHg") "parameter of the dissociation curve";

    Real Xpp=Ppp*(1 + beta*Ppp_gas2)/(k*(1 + alfa*Ppp_gas2));
    Pressure Ppp=Pa "Partial pressure of gas in pulmonary capilaries";
    parameter Pressure Patm=760*mmHg2Pa "mmHg atmospheric pressure";
    parameter Pressure Pws=47*mmHg2Pa
      "mmHg pressure of water vapor in alveoles";
    Pressure Pa=Fa*(Patm - Pws) "Alveolar partial pressure";


    Physiolibrary.Types.RealIO.FractionInput Fa
      "- fraction of gas in the alveoli" annotation (Placement(transformation(
            extent={{-120,-80},{-80,-40}}), iconTransformation(extent={{-120,-80},
              {-80,-40}})));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end AlveolarGasExchangeSI;

  model TestCircGas
    CirculationGas circulationGas(add(k1=-1, k2=1),
      subs_alveoli(solute_start=1e-08),
      arteries(useNormalizedVolume=true),
      subs_dead(solute_start=1e-08),
      concentrationDiff(Conc=1, useConcentrationInput=true),
      unlimitedSolutePump(SoluteFlow=8.6666666666667e-05))
      annotation (Placement(transformation(extent={{42,-2},{68,20}})));
    LungMechanics lungMechanics
      annotation (Placement(transformation(extent={{2,-18},{22,2}})));
    Modelica.Blocks.Sources.Constant RR(k=20) annotation (Placement(visible=
            true, transformation(
          origin={-58,26},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Physiolibrary.Types.Constants.PressureConst P_mus_min(k(displayUnit="Pa")=
           -490.333) annotation (Placement(visible=true, transformation(
          origin={-60,-8},
          extent={{-4,-4},{4,4}},
          rotation=0)));
    Physiolibrary.Types.TorsoBusConnector RespiratoryControl_Bus annotation (
        Placement(
        visible=true,
        transformation(
          origin={-22,26},
          extent={{-20,-20},{20,20}},
          rotation=0),
        iconTransformation(
          origin={-100,0},
          extent={{-20,-20},{20,20}},
          rotation=-90)));
  equation
    connect(RR.y, RespiratoryControl_Bus.RR) annotation (Line(points={{-47,26},
            {-22,26}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(P_mus_min.y, RespiratoryControl_Bus.Pmus_min) annotation (Line(
          points={{-55,-8},{-22,-8},{-22,26}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(lungMechanics.RespiratoryControl_Bus, RespiratoryControl_Bus)
      annotation (Line(
        points={{2,-8},{-4,-8},{-4,26},{-22,26}},
        color={129,194,194},
        thickness=1), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(lungMechanics.busConnector1, circulationGas.lungMech_bus)
      annotation (Line(
        points={{22,-8},{56,-8},{56,-2}},
        color={0,0,255},
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TestCircGas;

  model Airway
    extends Physiolibrary.Icons.BloodElasticCompartment;
    extends Physiolibrary.Hydraulic.Interfaces.OnePort;
    parameter Physiolibrary.Types.HydraulicCompliance c;
    parameter Physiolibrary.Types.Volume zero_press_vol;
    Physiolibrary.Types.Volume vol;
    parameter Physiolibrary.Types.Volume init_vol;
    Physiolibrary.Types.RealIO.VolumeOutput volume "Current volume in compartment" annotation (
      Placement(visible = true, transformation(origin = {20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  initial equation
    vol = init_vol;
  equation
    c * der(dp) = volumeFlowRate;
    vol = c * dp + zero_press_vol;
    volume = vol;
    annotation (
      Diagram(coordinateSystem(initialScale = 0.1)),
      Icon(graphics={  Text(origin = {-50, -75}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, extent = {{-50, 19}, {50, -19}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
  end Airway;
  annotation (uses(Physiolibrary(version="2.3.2-beta"), Modelica(version=
            "3.2.2")));
end BreathingModel;
