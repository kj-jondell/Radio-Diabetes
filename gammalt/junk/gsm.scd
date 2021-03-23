(
/***
*
* TODO Lägg till envelope...
*
*/
SynthDef.new(\rockingGSM, {
	arg bufnum = 0, freq = 110, freq2 = 0.0, freq3 = 0.0, pan = 0.0, amp = 1, amp1 = 1, amp2 = 0.8, amp3 = 0.5, formantPan = 0, gate = 1, attack = 1, release = 5,
	freqs = #[400, 750, 2400, 2600, 2900], q = #[0.1, 0.107, 0.04, 0.05, 0.05], amps = #[1, 0.28, 0.09, 0.1, 0.01];
	var signal = (PlayBuf.ar(1, bufnum: bufnum,  rate: [freq, if(freq2!=0){freq2}{freq}, if(freq3!=0){freq3}{freq}]/155.0/*,  trigger: 1.0*/, loop: 1,  doneAction: Done.freeSelf)*[amp1, amp2, amp3]).sum;
	var bandPass = BBandPass.ar(in: signal/*+LFNoise1.ar(freq: freq*2, mul: 0.01 + SinOsc.kr(0.25).unipolar(0.1))*/,  freq: freqs,  bw: q,  mul: amps*8).sum; 
	var panned = Pan2.ar(bandPass, pos: pan);
	var dryPanned = Pan2.ar(signal, pos: pan); 
	Out.ar(0, /*CombL.ar(in: */XFade2.ar(panned, dryPanned, pan: formantPan)*EnvGen.ar(Env.adsr(attack, release, amp), gate, doneAction:Done.freeSelf)/*, maxdelaytime: 10,  delaytime: SinOsc.kr(0.1, add: 0.5, mul: 0.01), decaytime: 5)*/);
}).add;
)
(
Server.default.waitForBoot({
	var synth;
	var pattern;
	//var buf = Buffer.read(Server.default, File.getcwd +/+ "media/monoGSM.wav");

	//Server.default.record;

	synth = Synth.new(\rockingGSM, [\attack, 10, \pan, 0, \freq, 110/*, \bufnum, buf*/]);

 	pattern = Penvir(
	  (formant: FormantTable.get(FormantTable.keys().choose)),
	  Pbind(
		\type, \set,
		\id, synth.nodeID,
		\args, #[\stretch, \freq, \freqs, \amps, \q, \formantPan, \freq2, \freq3, \pan, \gate],
		//\octave, 3,
		//\gtranspose, -2,
		//\degree, Pseq([0, 1, 4, -1], inf),
		\freq, Pseq([110, 125, 150, 100], inf),
		//\stretch, Pwhite(0.1, 3, inf),
		\dur, Pwrand.new([1.5, 1, 1.25, 1.75]*2,  weights: [1, 3, 1, 0].normalizeSum,  repeats: 4*32),
		\formant, Pfunc({~formant = FormantTable.get(FormantTable.keys().choose)}),
		\freqs, Pfunc({[~formant[0]]}),
		\amps, Pfunc({[~formant[1]]}),
		\q, Pfunc({[~formant[2]]}),
		\pan, Pwhite(-0.5,0.5,inf),
		//\gate, Pif(Pfunc({0.1.coin}), {pattern.stop; 0}, {1}),
		//\detuneFactor, Prand([0.5, 0, 1.0], inf),
		 \freq2, (Pkey(\freq)*Prand([0.5, 1, 2], inf)),
		 \freq3, (Pkey(\freq)*Prand([3/4, 4/3, 1.5], inf)),
		\formantPan, Pwhite.new(lo: -0.75,  hi: 0.75,  length: inf)
	  )
  ).play;

	// Pmono
	// ([110,125,150,100].wrapExtend(4*32)).do({
	// 	arg i;
	// 	synth.set(\freq, [i*[2,1,0.5].wchoose([0,5,3].normalizeSum), i*0.75*[2,1,0.5].wchoose([1,10,0].normalizeSum), i/2*[2,1,0.5].wchoose([1,8,2].normalizeSum)]);
	// 	#f,a,q = FormantTable.get(FormantTable.keys().choose);
	// 	synth.set(\freqs, f);
	// 	synth.set(\amps, a);
	// 	synth.set(\q, q);
	// 	synth.set(\formantPan, -1*(1.5.rand-0.5));
	// 	synth.set(\pan, 0.5.rand-0.25);
	// 	//synth.set(\formantPan, -1);
//	// 	synthKvint.set(\freq, i*0.75*[2,1,0.5].wchoose([1,10,0].normalizeSum));
//	// 	synthSept.set(\freq, i*[2,1,0.5].wchoose([0,5,3].normalizeSum));
	// 	[1.5,1,1.25,1.75].wchoose([1,3,1,1].normalizeSum).wait;

	// });

	//synth.free;

	//Server.default.stopRecording;

});
)

FormantTable.keys
{Formant.ar(100, 1000, 880)}.play

([1,2,3]*[1, 0.5, 1/3]).sum
s.meter
{SinOsc.kr(10).unipolar(0.001).poll}.play;
{ LFNoise1.ar(4000, 0.25) }.play;

{ Ringz.ar(WhiteNoise.ar(0.005), 2000, 0.5) }.play
{ Ringz.ar(WhiteNoise.ar(0.005), XLine.kr(100,3000,10), 0.5) }.play


Dust
