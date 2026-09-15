model Model3
  annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2})));
  Modelica.Blocks.Continuous.Integrator X4 
    annotation (Placement(transformation(origin={123.2799300590738,69.302350670692}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Continuous.Integrator X3 
    annotation (Placement(transformation(origin={168.14844748932404,69.04274372578995}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Continuous.Integrator X2 
    annotation (Placement(transformation(origin={-76.07762723942305,68.89509280194031}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Continuous.Integrator X1 
    annotation (Placement(transformation(origin={-21.605833890546208,69.20788180094333}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain(k=-20.58) 
    annotation (Placement(transformation(origin={-49.654208585681005,104.8126027304951}, 
extent={{-10,-10},{10,10}}, 
rotation=180)),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Sources.Step step 
    annotation (Placement(transformation(origin={-380.8876349507814,69.06839068232887}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain1(k=-1) 
    annotation (Placement(transformation(origin={-139.19001948553802,69.58358403615816}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain3(k=-0.49) 
    annotation (Placement(transformation(origin={39.589140323654085,69.10380050061775}, 
extent={{-10,-10},{10,10}}, 
rotation=360)),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain4(k=-0.5) 
    annotation (Placement(transformation(origin={37.232126578160035,129.93967368758604}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain5(k=1) 
    annotation (Placement(transformation(origin={243.1177234463566,69.5542275269027}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Feedback feedback 
    annotation (Placement(transformation(origin={-107.60793848442209,69.08317067543251}, 
extent={{-10,10},{10,-10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Feedback feedback1 
    annotation (Placement(transformation(origin={78.64743385914677,68.72298174887382}, 
extent={{-10,10},{10,-10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain2(k=-419.19) 
    annotation (Placement(transformation(origin={-48.68361375144423,-36.16327098257267}, 
extent={{-10,-10},{10,10}}, 
rotation=180)),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain6(k=-494.89) 
    annotation (Placement(transformation(origin={-18.82860296558268,-62.85187786949071}, 
extent={{-10,-10},{10,10}}, 
rotation=180)),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain7(k=-255.99) 
    annotation (Placement(transformation(origin={-65.81386842661313,17.652251281536625}, 
extent={{-10,-10},{10,10}}, 
rotation=180)),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain8(k=-982.02) 
    annotation (Placement(transformation(origin={-27.705415330709158,-16.586552631946233}, 
extent={{-10,-10},{10,10}}, 
rotation=180)),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Add3 add3_1 
    annotation (Placement(transformation(origin={-145.59131574761278,-28.25341788482503}, 
extent={{-10,-10},{10,10}}, 
rotation=180)),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Add add 
    annotation (Placement(transformation(origin={-186.1600594844124,-33.27870709947632}, 
extent={{-10,-10},{10,10}}, 
rotation=180)),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Feedback feedback2 
    annotation (Placement(transformation(origin={-199.7321477292693,70.24415934880653}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Feedback feedback3 
    annotation (Placement(transformation(origin={-340.6196593986691,68.55669005600778}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Math.Gain gain9(k=-306.12) 
    annotation (Placement(transformation(origin={-241.4068354373237,69.9229402551804}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
  Modelica.Blocks.Continuous.Integrator integrator 
    annotation (Placement(transformation(origin={-287.6447328612018,69.28954438552215}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(StateMachine)));
equation
  connect(X2.y, X1.u) 
  annotation(Line(origin={-49.24762810526069,69.33009698460812}, 
  points={{-15.829999134162364,-0.4350041826678108},{15.64179421471448,-0.4350041826678108},{15.64179421471448,-0.12221518366479245}}, 
  color={0,0,127}));
  connect(X4.y, X3.u) 
  annotation(Line(origin={192.85079568176633,99.5570047350312}, 
  points={{-58.57086562269251,-30.254654064339206},{-36.70234819244226,-30.254654064339206},{-36.70234819244226,-30.514261009241253}}, 
  color={0,0,127}));
  connect(X3.y, gain5.u) 
  annotation(Line(origin={248.5534694792405,78.1567500876527}, 
  points={{-69.40502198991643,-9.11400636186275},{-17.435746032883884,-9.11400636186275},{-17.435746032883884,-8.602522560750003}}, 
  color={0,0,127}));
  connect(gain3.u, X1.y) 
  annotation(Line(origin={14.817174551725358,61.08054110293671}, 
  points={{12.771965771928727,8.023259397681045},{-25.423008442271566,8.023259397681045},{-25.423008442271566,8.12734069800662}}, 
  color={0,0,127}));
  connect(gain.u, X1.y) 
  annotation(Line(origin={-15.182825448274642,87.0805411029367}, 
  points={{-22.471383137406363,17.732061627558394},{22.908512165048872,17.732061627558394},{22.908512165048872,-17.87265930199338},{4.576991557728434,-17.87265930199338}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
  connect(gain1.y, feedback.u1) 
  annotation(Line(origin={-119.18282544827464,70.0805411029367}, 
  points={{-9.00719403726336,-0.496957066778549},{3.574886963852549,-0.496957066778549},{3.574886963852549,-0.9973704275041939}}, 
  color={0,0,127}));
  connect(feedback.y, X2.u) 
  annotation(Line(origin={-93.18282544827464,69.0805411029367}, 
  points={{-5.425113036147451,0.0026295724958060873},{5.10519820885159,0.0026295724958060873},{5.10519820885159,-0.18544830099639853}}, 
  color={0,0,127}));
  connect(gain.y, feedback.u2) 
  annotation(Line(origin={-84.18282544827464,91.0805411029367}, 
  points={{23.528616862593637,13.732061627558394},{-23.42511303614745,13.732061627558394},{-23.42511303614745,-13.997370427504194}}, 
  color={0,0,127}));
  connect(gain3.y, feedback1.u1) 
  annotation(Line(origin={60.81717455172536,70.0805411029367}, 
  points={{-10.228034228071273,-0.9767406023189551},{9.830259307421414,-0.9767406023189551},{9.830259307421414,-1.3575593540628859}}, 
  color={0,0,127}));
  connect(feedback1.y, X4.u) 
  annotation(Line(origin={101.81717455172536,69.0805411029367}, 
  points={{-14.169740692578586,-0.35755935406288586},{9.462755507348447,-0.35755935406288586},{9.462755507348447,0.2218095677552867}}, 
  color={0,0,127}));
  connect(gain4.y, feedback1.u2) 
  annotation(Line(origin={56.81717455172536,108.0805411029367}, 
  points={{-8.585047973565324,21.85913258464933},{21.830259307421414,21.85913258464933},{21.830259307421414,-31.357559354062886}}, 
  color={0,0,127}));
  connect(gain8.u, X1.y) 
  annotation(Line(origin={-1.1828254482746416,40.08054110293671}, 
  points={{-14.522589882434517,-56.66709373488295},{8.473134029829497,-56.66709373488295},{8.473134029829497,29.12734069800662},{-9.423008442271566,29.12734069800662}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
  connect(gain7.u, X2.y) 
  annotation(Line(origin={-57.18282544827464,46.08054110293671}, 
  points={{3.3689570216615152,-28.428289821400085},{3.3689570216615152,22.8145516990036},{-7.89480179114841,22.8145516990036}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
  connect(gain6.u, X3.y) 
  annotation(Line(origin={188.81717455172537,37.08054110293671}, 
  points={{-195.64577751730803,-99.93241897242741},{5.507278489005245,-99.93241897242741},{5.507278489005245,31.96220262285324},{-9.668727062401302,31.96220262285324}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
  connect(gain2.u, X4.y) 
  annotation(Line(origin={134.81717455172537,35.08054110293671}, 
  points={{-171.5007883031696,-71.24381208550938},{5.985075501030707,-71.24381208550938},{5.985075501030707,34.22180956775529},{-0.5372444926515527,34.22180956775529}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
  connect(gain7.y, add3_1.u3) 
  annotation(Line(origin={-103.18282544827464,0.08054110293671002}, 
  points={{26.368957021661515,17.571710178599915},{-19.375914073429556,17.571710178599915},{-19.375914073429556,-20.33395898776174},{-30.408490299338155,-20.33395898776174}}, 
  color={0,0,127}));
  connect(gain8.y, add3_1.u2) 
  annotation(Line(origin={-84.18282544827464,-20.91945889706329}, 
  points={{45.47741011756548,4.332906265117055},{-29.162883401323654,4.332906265117055},{-29.162883401323654,-7.33395898776174},{-49.408490299338155,-7.33395898776174}}, 
  color={0,0,127}));
  connect(gain2.y, add3_1.u1) 
  annotation(Line(origin={-94.18282544827464,-34.91945889706329}, 
  points={{34.499211696830415,-1.2438120855093793},{-39.408490299338155,-1.2438120855093793},{-39.408490299338155,-1.33395898776174}}, 
  color={0,0,127}));
  connect(add3_1.y, add.u2) 
  annotation(Line(origin={-173.18282544827463,-25.91945889706329}, 
  points={{16.591509700661845,-2.33395898776174},{-0.9772340361377587,-2.33395898776174},{-0.9772340361377587,-1.3592482024130295}}, 
  color={0,0,127}));
  connect(gain6.y, add.u1) 
  annotation(Line(origin={-118.18282544827464,-49.91945889706329}, 
  points={{88.35422248269197,-12.932418972427413},{-52.74432510198548,-12.932418972427413},{-52.74432510198548,10.640751797586972},{-55.97723403613776,10.640751797586972}}, 
  color={0,0,127}));
  connect(feedback2.y, gain1.u) 
  annotation(Line(origin={-178.18282544827463,69.0805411029367}, 
  points={{-12.549322280994659,1.1636182458698272},{26.99280596273664,1.1636182458698272},{26.99280596273664,0.503042933221451}}, 
  color={0,0,127}));
  connect(add.y, feedback2.u2) 
  annotation(Line(origin={-211.18282544827463,14.08054110293671}, 
  points={{14.022765963862241,-47.35924820241303},{11.450677719005341,-47.35924820241303},{11.450677719005341,48.16361824586983}}, 
  color={0,0,127}));
  connect(feedback3.u2, X3.y) 
  annotation(Line(origin={-39.18282544827464,-9.91945889706329}, 
  points={{-301.4368339503945,70.47614895307107},{-301.4368339503945,-78.48039178167319},{253.52786664062455,-78.48039178167319},{253.52786664062455,78.96220262285324},{218.3312729375987,78.96220262285324}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
  connect(step.y, feedback3.u1) 
  annotation(Line(origin={-306.1828254482746,84.0805411029367}, 
  points={{-63.70480950250675,-15.012150420607838},{-42.43683395039449,-15.012150420607838},{-42.43683395039449,-15.523851046928925}}, 
  color={0,0,127}));
  connect(gain9.y, feedback2.u1) 
  annotation(Line(origin={-221.18282544827463,71.0805411029367}, 
  points={{-9.224009989049051,-1.1576008477563136},{13.450677719005341,-1.1576008477563136},{13.450677719005341,-0.8363817541301728}}, 
  color={0,0,127}));
  connect(integrator.y, gain9.u) 
  annotation(Line(origin={-265.1828254482746,70.0805411029367}, 
  points={{-11.46190741292719,-0.7909967174145578},{11.775990010950949,-0.7909967174145578},{11.775990010950949,-0.15760084775631356}}, 
  color={0,0,127}));
  connect(feedback3.y, integrator.u) 
  annotation(Line(origin={-315.1828254482746,69.0805411029367}, 
  points={{-16.436833950394487,-0.5238510469289253},{15.53809258707281,-0.5238510469289253},{15.53809258707281,0.2090032825854422}}, 
  color={0,0,127}));
  connect(gain4.u, feedback2.y) 
  annotation(Line(origin={-83.18282544827464,100.0805411029367}, 
  points={{108.41495202643468,29.85913258464933},{-81.99050711085994,29.85913258464933},{-81.99050711085994,-29.836381754130173},{-107.54932228099466,-29.836381754130173}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));

end Model3;