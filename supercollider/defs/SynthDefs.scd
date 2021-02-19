
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
		var panner = Pan2.ar(in: (resonator+signal),  pos: pan);
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
    var panner = Pan2.ar(in: signal,  pos: pan, level: -3.dbamp);
    var maximum = Peak.kr(signal, LFPulse.kr(5));
    var gate = EnvGen.ar(Env.asr(attackTime: 0.0035,releaseTime:0.08), gate: maximum-gate_level-midi_gate_level);
    Out.ar(out_bus, panner*gate);
}).add;


// 0.exit; // använd endast när script körs från terminalen


