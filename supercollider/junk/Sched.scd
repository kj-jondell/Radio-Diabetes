(
	var sched = Scheduler.new(SystemClock);

	sched.sched(3, {"now it is 3 seconds".postln; nil });
	sched.sched(5, {"now it is 5 seconds".postln; nil });
	sched.sched(1, {"now it is 1 seconds".postln; nil });

	sched.advance(0.5);
	sched.advance(0.5);
	sched.advance(2);
	sched.advance(2);
)
(

	var func, list;

	s.boot;

	func = OSCFunc.new({
		arg msg, time, addr, recvPort;
		[msg, time, addr, recvPort].postln;
		msg[1..].do({ arg val ; {(SinOsc.ar(val, mul:0.1)!2)*EnvGen.kr(Env.perc(), doneAction: Done.freeSelf)}.play;});
	}, '/hey', recvPort: 7771);

	func.add;
)
EnvGen.kr(Env.perc(),  gate: 1.0,  levelScale: 1.0,  levelBias: 0.0,  timeScale: 1.0,  doneAction: 0)
(
	~list.do({
		arg i, value;
		1.wait;
	});
)
[1,2,3].do({arg i; i.postln;})
Server.default.freeAll;
OSCFunc.trace(bool: false,  hideStatusMsg: false)
//PORT 57120!
