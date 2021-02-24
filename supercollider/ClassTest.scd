Quarks.install("MathLib");
Quarks.install("Require");
Quarks.install("JITLib");
"JITLibExtensions".include;
Quarks.openFolder
thisProcess.recompile;

Quarks.clear
Quarks.install(File.getcwd +/+ "classes");
s.boot;

thisProcess.recompile;

Server.killAll
(
	s.reboot;
	Buffer.freeAll;
)
(
	Require("defs/SynthDefs"); //loading synthdefs...
	////////// LOAD BUFFERS \\\\\\\\\\
	SoundFile.collectIntoBuffers(File.getcwd +/+ "defs/media/normalized/*",  server: Server.default);
)
~objects.postln;
b.postln;
q.size;
b = List.new();
(
	Require("defs/SynthDefs"); //loading synthdefs...
	Server.default.waitForBoot({
		var randValues, randValues2;
		var counter = 0;
		var objects = List.new();
		var glucoseObject = BloodGlucose.new(s, {
			arg argm;
			b.remove(argm);
		});
		b.add(glucoseObject);

		randValues = Array.fill(100, {arg i; 2.0+28.0.rand;});
		randValues2 = Array.fill(100, {arg i; 2.0+28.0.rand;});

		// [randValues.mean,randValues.maxItem,randValues.minItem,randValues.stdDev,randValues.variance,randValues.geoMean,randValues.autocorr,randValues.corr(randValues2)].do({
		// 	arg value;
		// 	value.postln;
		// });
		// Server.default.sync;

		////////// LOAD OBJECT \\\\\\\\\\
		randValues.do({
			arg value, i;
			glucoseObject.addValue(value);
		});

		// fork {
		// 	loop {
		// 		(TempoClock.default.seconds-glucoseObject.startTime).postln;
		// 		1.wait;
		// 	}
		// };

		glucoseObject.createPatterns();

		b[0].postln;
		TempoClock.default.sched(1,{
			glucoseObject.play(maxTime: 100, minTime: 4, fadeIn: 1, fadeOut: 1, instrument: [\sliceBuffer, \sin].choose);
		})

		//s.meter;
	});
)
(
b.do({
	arg val;
	val.hasWaiting = true;
});
)
		b[0].postln;

// Logik:
// 1. Nytt osc-paket anländer
// 2. Kolla om lista är full
//	a. om listan är full, köa nytt paket
//	b. annars lägg till i lista och starta
// 

TempoClock.default.sched(1, {"hello".postln});

TempoClock.default.secs2beats(TempoClock.default.seconds);
~glucoseObject.player.start;
~glucoseObject.player.isPlaying


[1,2,3].asStream.next.postln

[1,2,3].harmMean
[1,2,3].geoMean
[1,2,3].stdDev
[1,2,3].stdDevPop
[1,2,3].percentile(0.25)
[1,3,5].percentile([0.25, 0.75])
[1,2,4].variancePop
([3,0,3,1,1,1,1,2,3].histo(3)-1).plot
[0,1,2,-1,1,2,3,4].autocorr
[0,0,0].corr([3,1,1,2,2,3][1..3])


s.queryAllNodes;
// TODO ta bort om inte behövs...
// (
// SynthDef.new(\sin, {
// 	arg freq = 110;
// 	var left = SinOsc.ar(freq,  phase: 0.0, mul: 0.1,  add: 0.0),
// 	right = SinOsc.ar(freq,  phase: pi*2.0.rand, mul: 0.1,  add: 0.0);
// 	var env = EnvGen.kr(Env.perc,  gate: 1.0,  levelScale: 1.0,  levelBias: 0.0,  timeScale: 1.0,  doneAction: Done.freeSelf);
// 	Out.ar(0, [left, right]*env);
// }).add;
// )
