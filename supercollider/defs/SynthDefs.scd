
/**
*
* Diabetes wavetable synth def
* TODO: ändra namn
*
**/
SynthDef.new(
    \Diabetes,
    {
        arg freq = 440, velocity = 67, attackTime = 0.01, releaseTime = 0.1, decayTime = 0.8, pan = 0, sustainLevel = 0.6, detuneFactor = 1.0, bufferNum = 1, outBus = 0, gate = 1, flutter = 0.0002, orderSize = 10 ;

        var freq_ = freq*BrownianWalk.kr(flutter);

        var sig = VOsc3.ar((bufferNum+LFTri.kr(0.05).unipolar(mul: velocity.linlin(0,127,1,orderSize/2))).wrap(bufferNum, bufferNum+orderSize), freq1:freq_, freq2:freq_*(1.0-(detuneFactor)), freq3:freq_*(1.0+(detuneFactor)), mul: Lag2.kr(velocity.linlin(0,127,-15,-6).dbamp));

        var filter = BLowPass4.ar(sig, (freq*Lag2.kr(velocity.linlin(0,127,1.0,5.0))).clip(1,20000), Lag2.kr(velocity.linlin(0,127,1.0,2.0)));//TODO FIX blowpasss cutoff frequency!!

        var env = FreeSelfWhenDone.kr(EnvGen.ar(Env.adsr(attackTime: attackTime, decayTime: decayTime, sustainLevel: sustainLevel, releaseTime: releaseTime, curve: -4.0), gate: gate));

        var panned = Pan2.ar(filter, pan);

        Out.ar(outBus, LeakDC.ar(panned*env));
    }
).add; //TODO använd 'writeDefFile' i framtiden...
//).writeDefFile;

/**
*
* Trummaskin...
*
**/
SynthDef.new(\sliceBuffer, {
		arg bufnum = 0, rate = 1, pan = 0, outBus = 0, amp = 0.5, attack = 0.01, release = 0.8, freq = 220, resonantAmp = 0.25;
		var signal = PlayBuf.ar(2, bufnum, rate*BufRateScale.kr(bufnum)/*, doneAction:Done.freeSelf*/);
		var delayTime = 1 / (freq);
		var resonator = CombL.ar(signal, delayTime, delayTime, release)*resonantAmp;
		var combined = (resonator+signal);
		var panner = Balance2.ar(left: combined[0], right: combined[1],  pos: pan);
		//Använd detectsilence istället? env endast på resonans....
		Out.ar(outBus, EnvGen.kr(Env.perc(attackTime: attack, releaseTime: release), doneAction:Done.freeSelf)*Limiter.ar(panner, level: amp));
	}).add;

/**
*
* Ha med denna? Kanske...
*
**/
SynthDef.new(\gatedBuffer, {
    arg bufnum, rate = 1, pan = 0, gate_level = 0.2, midi_gate_level = 0.0, out_bus = 2;
    var signal = PlayBuf.ar(2, bufnum, rate*BufRateScale.kr(bufnum), loop: 1);
    var panner = Balance2.ar(left: signal[0], right: signal[1],  pos: pan, level: -3.dbamp);
    var maximum = Peak.kr(signal, LFPulse.kr(5));
    var gate = EnvGen.ar(Env.asr(attackTime: 0.0035,releaseTime:0.08), gate: maximum-gate_level-midi_gate_level);
    Out.ar(out_bus, panner*gate);
}).add;


SynthDef.new(\sin,  {
	arg freq = 110, pan=0, release = 1, attack = 0.1;
	var sinOsc = SinOsc.ar(freq, mul:0.1)*EnvGen.kr(Env.perc(/*attackTime: attack,*/ releaseTime: release), doneAction: Done.freeSelf);
	Out.ar(0, Pan2.ar(in: sinOsc, pos: pan));
}).add;

/*
* TODO Fixa grejer (reverb t.ex....)
*/
SynthDef.new(\rockingGSM, {
	arg bufnum = 0, freq = 110, freq2 = 0.0, freq3 = 0.0, pan = 0.0, amp = 1, amp1 = 1, amp2 = 0.8, amp3 = 0.5, formantPan = 0, gate = 1, attack = 1, release = 5,
	freqs = #[400, 750, 2400, 2600, 2900], q = #[0.1, 0.107, 0.04, 0.05, 0.05], amps = #[1, 0.28, 0.09, 0.1, 0.01];

	var signal, bandPass, panned, dryPanned, mixed, env;

	 if(freq2==0){
	   freq2 = freq;
	 };

	 if(freq3==0){
	   freq3 = freq;
	 };

	signal = LPF.ar((PlayBuf.ar(1, bufnum: bufnum,  rate: [freq, freq2, freq3]/155.0, loop: 1,  doneAction: Done.freeSelf)*[amp1, amp2, amp3]).sum, amp.linlin(0, 1.5, 1000, 6000)); //TOOO ändra filter? ?? 
	bandPass = BBandPass.ar(in: signal,  freq: [freq]++freqs,  bw: [0.1]++q,  mul: ([1]++amps)*8).sum; 

	panned = Pan2.ar(bandPass, pos: pan);
	dryPanned = Pan2.ar(signal, pos: pan); 

	mixed = XFade2.ar(panned, dryPanned, pan: formantPan);
	env = EnvGen.ar(Env.adsr(attack, release, amp), gate, doneAction:Done.freeSelf);

	signal = mixed*env;
	Out.ar(0, XFade2.ar(signal, JPverb.ar(signal, 3.0, damp: 0.4, low: 1.2, high: 1.2, earlyDiff: 0.8), pan: -0.25));

}).add;

/*
* TODO ta bort...
*/
SynthDef.new(\rockingGSMOLD, {
	arg bufnum = 0, freq = 110, pan = 0, amp = 1;
	var signal = PlayBuf.ar(2, bufnum: bufnum,  rate: freq/155.0/*,  trigger: 1.0*/, loop: 1,  doneAction: Done.freeSelf);
	signal = Balance2.ar(left: signal[0], right: signal[1], pos: pan, level: amp);
	Out.ar(0, signal);
}).add;
