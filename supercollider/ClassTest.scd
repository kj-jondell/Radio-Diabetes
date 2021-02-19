Quarks.install("Require");
Quarks.openFolder
thisProcess.recompile;

Quarks.install(File.getcwd +/+ "classes");


s.boot;

thisProcess.recompile;

Server.killAll
(
	Require("defs/SynthDefs"); //loading synthdefs...
	Server.default.waitForBoot({
		var glucoseObject = BloodGlucose.new();
		var randValues, slices;

		randValues = Array.fill(100, {arg i; 2.0+28.0.rand;});

		////////// LOAD BUFFERS \\\\\\\\\\
		slices = SoundFile.collectIntoBuffers(File.getcwd +/+ "defs/media/normalized/*",  server: Server.default);

		// Server.default.sync;

		////////// LOAD OBJECT \\\\\\\\\\
		randValues.do({
			arg value, i;
			glucoseObject.addValue(value);
		});

		glucoseObject.createPatterns();
		glucoseObject.play();

		Synth.new(\sin);

	});
)

Server.default.queryAllNodes;
p = Pbind(\degree, Pwhite(0, 7, inf), \dur, 0.25, \legato, 1).asStream;
p.next(())

Pbind(\freq, Prand([300, 500, 231.2, 399.2], inf), \dur, 0.1).play;

(
Pbind(
    \curve, Pseg(Pseq([0, 1, 0], 1), 15),
    \degree, Pwhite(-7, 0, inf) + Pkey(\curve).linlin(0, 1, 0, 14).asInteger,
    \dur, 0.5,
    \tempo, Pkey(\curve).linlin(0, 1, 1, 10)
).play;
)

SimpleNumber.new 
2.1.clip(1.5,2)

s.scope;
s.meter

thisProcess.recompile;
(
SynthDef.new(\sin, {
	arg freq = 110;
	var left = SinOsc.ar(freq,  phase: 0.0, mul: 0.1,  add: 0.0),
	right = SinOsc.ar(freq,  phase: pi*2.0.rand, mul: 0.1,  add: 0.0);
	var env = EnvGen.kr(Env.perc,  gate: 1.0,  levelScale: 1.0,  levelBias: 0.0,  timeScale: 1.0,  doneAction: Done.freeSelf);
	Out.ar(0, [left, right]*env);
}).add;
)
