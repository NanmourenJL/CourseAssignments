model Model4
  Modelica.Blocks.Continuous.Integrator X4 
    annotation (Placement(transformation(origin={121.46275550734845,91.22180956775529}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Continuous.Integrator X3 
    annotation (Placement(transformation(origin={166.3312729375987,90.96220262285324}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Continuous.Integrator X2 
    annotation (Placement(transformation(origin={-77.89480179114841,90.8145516990036}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Continuous.Integrator X1 
    annotation (Placement(transformation(origin={-23.423008442271566,91.12734069800662}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Gain gain(k=-20.58) 
    annotation (Placement(transformation(origin={-51.47138313740636,126.7320616275584}, 
extent={{-10,-10},{10,10}}, 
rotation=180)));
  Modelica.Blocks.Sources.Step step 
    annotation (Placement(transformation(origin={-216.59806062049196,91.63670406721253}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) 
    annotation (Placement(transformation(origin={-141.00719403726336,91.50304293322145}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain3(k=-0.49) 
    annotation (Placement(transformation(origin={37.77196577192873,91.02325939768104}, 
extent={{-10,-10},{10,10}}, 
rotation=360)),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain4(k=-0.5) 
    annotation (Placement(transformation(origin={35.414952026434676,151.85913258464933}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain5(k=1) 
    annotation (Placement(transformation(origin={241.30054889463125,91.47368642396599}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Feedback feedback 
    annotation (Placement(transformation(origin={-109.42511303614745,91.0026295724958}, 
extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Math.Feedback feedback1 
    annotation (Placement(transformation(origin={76.83025930742141,90.64244064593711}, 
extent={{-10,10},{10,-10}})));
  annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2})));
  equation
  connect(X2.y, X1.u) 
  annotation(Line(origin={-51.064802656986046,91.24955588167141}, 
points={{-15.829999134162364,-0.4350041826678108},{15.64179421471448,-0.4350041826678108},{15.64179421471448,-0.12221518366479245}}, 
color={0,0,127}));
  connect(X4.y, X3.u) 
  annotation(Line(origin={191.03362113004096,121.4764636320945}, 
points={{-58.57086562269251,-30.254654064339206},{-36.70234819244226,-30.254654064339206},{-36.70234819244226,-30.514261009241253}}, 
color={0,0,127}));
  connect(X3.y, gain5.u) 
  annotation(Line(origin={246.73629492751513,100.07620898471599}, 
points={{-69.40502198991643,-9.11400636186275},{-17.435746032883884,-9.11400636186275},{-17.435746032883884,-8.602522560750003}}, 
color={0,0,127}));
  connect(gain3.u, X1.y) 
  annotation(Line(origin={13,83}, 
points={{12.771965771928727,8.023259397681045},{-25.423008442271566,8.023259397681045},{-25.423008442271566,8.12734069800662}}, 
color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
  connect(gain.u, X1.y) 
  annotation(Line(origin={-17,109}, 
  points={{-22.471383137406363,17.732061627558394},{22.908512165048872,17.732061627558394},{22.908512165048872,-17.87265930199338},{4.576991557728434,-17.87265930199338}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
  connect(gain1.y, feedback.u1) 
  annotation(Line(origin={-121,92}, 
points={{-9.00719403726336,-0.496957066778549},{3.574886963852549,-0.496957066778549},{3.574886963852549,-0.9973704275041939}}, 
color={0,0,127}));
  connect(feedback.y, X2.u) 
  annotation(Line(origin={-95,91}, 
points={{-5.425113036147451,0.0026295724958060873},{5.10519820885159,0.0026295724958060873},{5.10519820885159,-0.18544830099639853}}, 
color={0,0,127}));
  connect(gain.y, feedback.u2) 
  annotation(Line(origin={-86,113}, 
  points={{23.528616862593637,13.732061627558394},{-23.42511303614745,13.732061627558394},{-23.42511303614745,-13.997370427504194}}, 
  color={0,0,127}));
  connect(gain3.y, feedback1.u1) 
  annotation(Line(origin={59,92}, 
points={{-10.228034228071273,-0.9767406023189551},{9.830259307421414,-0.9767406023189551},{9.830259307421414,-1.3575593540628859}}, 
color={0,0,127}));
  connect(feedback1.y, X4.u) 
  annotation(Line(origin={100,91}, 
points={{-14.169740692578586,-0.35755935406288586},{9.462755507348447,-0.35755935406288586},{9.462755507348447,0.2218095677552867}}, 
color={0,0,127}));
  connect(gain4.y, feedback1.u2) 
  annotation(Line(origin={55,130}, 
points={{-8.585047973565324,21.85913258464933},{21.830259307421414,21.85913258464933},{21.830259307421414,-31.357559354062886}}, 
color={0,0,127}));
  connect(step.y, gain1.u) 
  annotation(Line(origin={-204,92}, 
points={{-1.5980606204919638,-0.36329593278746586},{50.99280596273664,-0.36329593278746586},{50.99280596273664,-0.496957066778549}}, 
color={0,0,127}));
  connect(gain4.u, step.y) 
  annotation(Line(origin={-91,122}, 
  points={{114.41495202643468,29.85913258464933},{-84.83956619932027,29.85913258464933},{-84.83956619932027,-30.363295932787466},{-114.59806062049196,-30.363295932787466}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
  end Model4;