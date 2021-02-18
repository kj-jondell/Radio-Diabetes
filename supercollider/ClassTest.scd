Quarks.install(File.getcwd +/+ "classes");
Quarks.uninstall(File.getcwd +/+ "classes");
Quarks.clear;
thisProcess.recompile;

(
	Server.default.waitForBoot({
		var glucoseObject = BloodGlucose.new();
		var randValues;

		randValues = Array.fill(10, {arg i; 2.0+10.0.rand;});

		randValues.do({
			arg value, i;
			glucoseObject.addValue(value);
		});

		glucoseObject.createPatterns();
		glucoseObject.play();

	});
)
Server.default.queryAllNodes
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
