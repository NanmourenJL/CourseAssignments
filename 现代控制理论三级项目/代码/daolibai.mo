model InvertedPendlum "倒立摆模型"
  inner Modelica.Mechanics.MultiBody.World world 
    annotation (Placement(transformation(origin={-104,-22}, 
extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic 
    annotation (Placement(transformation(origin={-60,-22}, 
extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute(useAxisFlange=true,phi(start=0.261799387799149)) 
    annotation (Placement(transformation(origin={-16,-22}, 
extent={{10,10},{-10,-10}})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape(m=2,r_shape={-0.125,0,0},shapeType="box", length = 0.25, width = 0.125, animateSphere = false, color = {0, 180, 0}) 
    annotation (Placement(transformation(origin={-60,14}, 
extent={{-10,-10},{10,10}}, 
rotation=180)));
  Modelica.Mechanics.MultiBody.Parts.Body body(r_CM={0,0.5,0},m=0.1) 
    annotation (Placement(transformation(origin={28,-22}, 
extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsolutePosition absolutePosition 
    annotation (Placement(transformation(origin={-2,14}, 
extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteVelocity absoluteVelocityV 
    annotation (Placement(transformation(origin={-2,50}, 
extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor 
    annotation (Placement(transformation(origin={8,-88}, 
extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor 
    annotation (Placement(transformation(origin={8,-58}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Gain gain(k=-982.02) 
    annotation (Placement(transformation(origin={-40,-116}, 
extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Math.Gain gain1(k=-255.99) 
    annotation (Placement(transformation(origin={-56.6667,-138.667}, 
extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Math.Gain gain2(k=-494.89) 
    annotation (Placement(transformation(origin={-73.3333,-161.333}, 
extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Math.Gain gain3(k=-419.19) 
    annotation (Placement(transformation(origin={-90,-184}, 
extent={{10,-10},{-10,10}})));
  Modelica.Mechanics.MultiBody.Forces.WorldForce force 
    annotation (Placement(transformation(origin={-104,14}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant const(k=0) 
    annotation (Placement(transformation(origin={-156,50}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant const1(k=0) 
    annotation (Placement(transformation(origin={-156,14}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Feedback feedback 
    annotation (Placement(transformation(origin={-202,-22}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Sum sum1(nin=4) 
    annotation (Placement(transformation(origin={-156,-138.667}, 
extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Math.Gain gain4(k=-306.12) 
    annotation (Placement(transformation(origin={-234,-22}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Continuous.Integrator integrator 
    annotation (Placement(transformation(origin={-278,-22}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Feedback feedback1 
    annotation (Placement(transformation(origin={-322,-22}, 
extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table={{0.0, 1}, {1, 1}, {8, 1}, {8, -1}, {16, -1}, {16, 0}, {17, 0}}) 
    annotation (Placement(transformation(origin={-366,-22}, 
extent={{-10,-10},{10,10}})));
  annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2})),Documentation(info="<html><p>
<br>
</p>
</html>"));
equation
  connect(world.frame_b, prismatic.frame_a) 
  annotation(Line(origin={-82,-22}, 
points={{-12,0},{12,0}}, 
color={95,95,95}, 
thickness=0.5));
  connect(absoluteVelocityV.frame_a, bodyShape.frame_a) 
  annotation(Line(origin={-31,32}, 
points={{19,18},{-7,18},{-7,-18},{-19,-18}}, 
color={95,95,95}, 
thickness=0.5));
  connect(absolutePosition.frame_a, bodyShape.frame_a) 
  annotation(Line(origin={-31,14}, 
points={{19,0},{-19,0}}, 
color={95,95,95}, 
thickness=0.5));
  connect(angleSensor.flange, revolute.axis) 
  annotation(Line(origin={-9,-45}, 
points={{7,-43},{-7,-43},{-7,13}}, 
color={0,0,0}));
  connect(speedSensor.flange, revolute.axis) 
  annotation(Line(origin={-9,-57}, 
points={{7,-1},{-7,-1},{-7,25}}, 
color={0,0,0}));
  connect(angleSensor.phi, gain.u) 
  annotation(Line(origin={10,-102}, 
  points={{9,14},{38,14},{38,-14},{-38,-14}}, 
  color={0,0,127}));
  connect(speedSensor.w, gain1.u) 
  annotation(Line(origin={13,-98}, 
  points={{6,40},{57,40},{57,-40.6667},{-57.6667,-40.6667}}, 
  color={0,0,127}));
  connect(absolutePosition.r[1], gain2.u) 
  annotation(Line(origin={17,-74}, 
  points={{-8,88},{79,88},{79,-87.3333},{-78.3333,-87.3333}}, 
  color={0,0,127}));
  connect(absoluteVelocityV.v[1], gain3.u) 
  annotation(Line(origin={25,-67}, 
  points={{-16,117},{103,117},{103,-117},{-103,-117}}, 
  color={0,0,127}));
  connect(bodyShape.frame_b, force.frame_b) 
  annotation(Line(origin={-82,14}, 
  points={{12,0},{-12,-3.55271e-15}}, 
  color={95,95,95}, 
  thickness=0.5));
  connect(const.y, force.force[3]) 
  annotation(Line(origin={-130,32}, 
points={{-15,18},{2,18},{2,-18},{14,-18}}, 
color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
  connect(const1.y, force.force[2]) 
  annotation(Line(origin={-130,14}, 
  points={{-15,-3.55271e-15},{14,-3.55271e-15}}, 
  color={0,0,127}));
  connect(feedback.y, force.force[1]) 
  annotation(Line(origin={-154,-4}, 
  points={{-39,-18},{26,-18},{26,18},{38,18}}, 
  color={0,0,127}));
  connect(gain.y, sum1.u[1]) 
  annotation(Line(origin={-97,-127}, 
  points={{46,11},{-7,11},{-7,-11.6667},{-47,-11.6667}}, 
  color={0,0,127}));
  connect(gain1.y, sum1.u[2]) 
  annotation(Line(origin={-106,-139}, 
  points={{38.3333,0.333333},{-38,0.333333}}, 
  color={0,0,127}));
  connect(gain2.y, sum1.u[3]) 
  annotation(Line(origin={-114,-150}, 
  points={{29.6667,-11.3333},{10,-11.3333},{10,11.3333},{-30,11.3333}}, 
  color={0,0,127}));
  connect(gain3.y, sum1.u[4]) 
  annotation(Line(origin={-122,-161}, 
  points={{21,-23},{18,-23},{18,22.3333},{-22,22.3333}}, 
  color={0,0,127}));
  connect(sum1.y, feedback.u2) 
  annotation(Line(origin={-184,-84}, 
  points={{17,-54.667},{-18,-54.667},{-18,54}}, 
  color={0,0,127}));
  connect(feedback.u1, gain4.y) 
  annotation(Line(origin={-216,-22}, 
  points={{6,0},{-7,0}}, 
  color={0,0,127}));
  connect(gain4.u, integrator.y) 
  annotation(Line(origin={-250,-22}, 
points={{4,0},{-17,0}}, 
color={0,0,127}));
  connect(feedback1.y, integrator.u) 
  annotation(Line(origin={-299,-21}, 
points={{-14,-1},{9,-1}}, 
color={0,0,127}));
  connect(absolutePosition.r[1], feedback1.u2) 
  annotation(Line(origin={-113,-97}, 
  points={{122,111},{209,111},{209,-111},{-209,-111},{-209,67}}, 
  color={0,0,127}));
  connect(timeTable.y, feedback1.u1) 
  annotation(Line(origin={-344,-21}, 
points={{-11,-1},{14,-1}}, 
color={0,0,127}));
  connect(prismatic.frame_b, revolute.frame_b) 
  annotation(Line(origin={-38,-22}, 
  points={{-12,0},{12,0}}, 
  color={95,95,95}, 
  thickness=0.5));
  connect(revolute.frame_a, body.frame_a) 
  annotation(Line(origin={6,-22}, 
  points={{-12,0},{12,0}}, 
  color={95,95,95}, 
  thickness=0.5));
  connect(bodyShape.frame_a, revolute.frame_b) 
  annotation(Line(origin={-38,-4}, 
  points={{-12,18},{0,18},{0,-18},{12,-18}}, 
  color={95,95,95}, 
  thickness=0.5));
  end InvertedPendlum;