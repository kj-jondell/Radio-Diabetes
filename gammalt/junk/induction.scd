s.boot;
(
)
(
	SynthDef.new(\induction, {
		arg numFrames, t_trig, start, bufnum = 0, freq = 110, pan = 0.0, amp = 1, gate = 1, attack = 1, release = 5;

		var signal, env;

		signal = PlayBuf.ar(2, bufnum: bufnum, trigger: t_trig, startPos: start*numFrames,  rate: freq/100.0, loop: 1);
		env = EnvGen.ar(Env.perc(attackTime: attack, releaseTime: release)/*Env.adsr(attackTime: attack, releaseTime: release, sustainLevel: 1.0)*/, gate: t_trig);

		signal = signal*env;
		Out.ar(0, [CombL.ar(signal[0], 0.5, 0.125, 1), CombL.ar(signal[1], 0.5, 0.122. 1)]);

	}).add;
)
(
	SynthDef.new(\inductionSelf, {
		arg numFrames, start, bufnum = 0, freq = 110, pan = 0.0, amp = 1, gate = 1, attack = 1, release = 5, cutoffFactor = 4, level = 1.0;

		var signal, env, freqAttackMod = 0;

		signal = PlayBuf.ar(2, bufnum: bufnum, startPos: start*numFrames,  rate: (/*freqAttackMod*EnvGen.kr(Env.perc(attackTime: 0, releaseTime: 0.01))+*/freq)/100.0, loop: 0);
		env = EnvGen.ar(/*Env.perc(attackTime: attack, releaseTime: release)*/Env.adsr(attackTime: attack, releaseTime: release, sustainLevel: 1.0), gate: gate, doneAction: Done.freeSelf);

		signal = signal*env;
		signal = LPF.ar(signal,  freq: (freq+(EnvGen.kr(Env.perc(attackTime:0,releaseTime:release/cutoffFactor.linlin(1,20,10,1)), levelBias: 1)*freq*cutoffFactor)).clip(1,20000), mul: 1.0, add: 0.0);
		signal = signal+Ringz.ar(signal,  freq: (5.rand+3)*freq, mul: 0.002.rand, decaytime: release/4, add: 0.0);
		signal = Balance2.ar(left: signal[0], right: signal[1], pos: pan, level: level);

		DetectSilence.ar(signal,  amp: 0.0001,  time: 1,  doneAction: Done.freeSelf);
		Out.ar(0, signal);
	}).add;

)

s.reboot;
~buffer = Buffer.read(s, "induktion-sc.wav");
Server.killAll
s.freeAll;


(
	var bufnum, numFrames, parA, parB;
	//s.record;
	bufnum = ~buffer.bufnum;
	numFrames = ~buffer.numFrames;
	parA = Pbind.new(
		\instrument, \inductionSelf,
		\bufnum, bufnum,
		\numFrames, numFrames,
		\pan, -0.1,
		\stutter, Pwrand([1,3,5], [20,1,0.1].normalizeSum, inf),
		\freq, (Pwrand([99.34, 132.60, [198.67, 265.2, 2*148.83/*, 446/4*/], 148.83], [5, 1, 1, 1].normalizeSum, inf)*Pwrand([440, 446]/446, [3, 10].normalizeSum, inf)).stutter(Pkey(\stutter)),//*(132.6/99.34),
		\start, (Pwrand([0.1, 0.25, 0.3, 0.45,/* 0.5,*/ 0.67/*, 0.94*/], [5, 8, 1, 2, 3].normalizeSum, inf)+Pwhite(-0.01, 0.01, inf)).stutter(Pkey(\stutter)),
		\attack, Pwhite(0.0, 0.005, inf),
		\level, 0.7*Pfunc{
			arg event; 
			if(event[\freq].size > 1)
			{[0.5, 0.2, 0.15]*0.75;}
			{event[\freq]/(148.83)}
		},
		\strum, Pfunc({if(0.1.coin){1/12}{0}}),
		\release, (2*Pkey(\start)).clip(0.75,1.75)*Pwrand([0.5, 1.5, 3, 0.75, 4], [10, 10, 3, 7, 0.1].normalizeSum, inf).stutter(Pkey(\stutter)),
		\cutoffFactor, Pwhite(7, 16, inf).stutter(Pkey(\stutter)),
		\legato, Pexprand.new(lo: 0.1,  hi: 1.5,  length: inf),
		\dur, Pwrand([1/8, Pseq([1/16], 4)], [100, 1].normalizeSum, inf).stutter(Pkey(\stutter))
		//\dur, [1/8, 1/4].choose
		/*Pfunc{
		  arg event; 
		  if(event[\freq].size > 1)
		  {1/6}
		  {1/8}
		}*/

	);//.stutter(Pwrand([1,2,3,4], [50,1,1,0.5].normalizeSum, inf));
	parB = Pbind.new(
		\instrument, \inductionSelf,
		\bufnum, bufnum,
		\numFrames, numFrames,
		\pan, 0.1,
		\freq, Pwrand([99.34, 132.60, 198.67, 148.83], [0.1, 5, 5, 1].normalizeSum, inf)*Pwrand([440, 446]/446, [1, 10].normalizeSum, inf),//*(132.6/99.34),
		\start, Pwrand([/*0.01,*/ 0.25, 0.3, 0.45,/* 0.5,*/ 0.67, 0.94], [8, 1, 5, 2, 1].normalizeSum, inf)+Pwhite(-0.0025, 0.0025, inf),
		\attack, Pwhite(0.0, 0.01, inf),
		\level, Pkey(\freq)/(148.83*2.5),
		\legato, 0.1,
		\cutoffFactor, Pwhite(3, 10, inf),
		\release, Pwrand([0.5, 1.5, 3, 0.75, 5]*1.4, [10, 10, 0.1, 7, 0.01].normalizeSum, inf),
		\dur, [1/4, 1/5, 1/7].wchoose([0, 15, 15].normalizeSum)
	);
	parA.play;
	parB.play;
	//Ppar([parA, parB]).play;
)
	~parA.play(quant: 1);
[1,[1,2],3].stutter(2)

(
	var bufnum, numFrames;
	bufnum = ~buffer.bufnum;
	numFrames = ~buffer.numFrames;
	~synth = Synth.new(\induction, [\freq, 110, \bufnum, bufnum, \numFrames, numFrames, \t_trig, 1]);
)
(
	~synth.set(\start, 0.3, \t_trig, 1, \freq, [98, 131, 196].choose);
)
(
	Pbind.new(
		\type, \set,
		\id, ~synth.nodeID,
		\args, #[\start, \t_trig, \freq, \dur, \attack, \release],
		\freq, Prand([100, 110, 125], inf),
		//\degree, Pseq([1], inf),
		//\octave, 4,
		\start, Pwhite(0.0, 1.0, inf),
		\attack, Pwhite(0.0, 0.2, inf),
		\release, Pwhite(1.5,3, inf),
		\t_trig, 1,
		\dur, Pseq.new([0.125,0.25], inf)
	).play;

)
{EnvGen.kr(Env.perc(attackTime:0,releaseTime:1), levelBias: 0.75)}.plot(duration:1)
[1,2].size
