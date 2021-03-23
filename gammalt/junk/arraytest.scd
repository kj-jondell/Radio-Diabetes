
[1,2,3].linlin(0,20,10,100)
(
var randValues2 = Array.fill(100, {arg i; 2.0+28.0.rand;});
~randValues2.bSplineInt(1,10)
)


(
	var hello = "Hello2";
	hello.postln;
)

s.boot;
s.freeAll;
Buffer.freeAll;
(
var randValues2 = Array.fill(1024, {arg i; 2.0+28.0.rand;});
var signal = randValues2.as(Signal).normalizeTransfer()*Signal.hanningWindow(1024);
//var signal = Signal.newClear(1024);
//signal = signal.fill(~randValues2).normalizeTransfer()*Signal.hanningWindow(1024);
//Signal.hanningWindow(256).plot;
//signal.play(loop:false, numChannels: 1);
signal.plot;

)
(
thisProcess.removeOSCRecvFunc(f);
f = { |msg, time, addr|
  if(msg[0] == '/newPacket'){
	~points = Array.new();
  };
    if(msg[0] == '/value') {
		~points = ~points.add(Point.new(msg[2], msg[1]));
        //"% and %, ".postf(msg[1],msg[2]);
    }
};
thisProcess.addOSCRecvFunc(f);
)
~values = Array.new();
~times = Array.new();
~points[..100]
Quarks.install("splines")

~points[..100].bSplineInt()
y = BSpline.new(~points[..1000])
y.gui
[1,2,3]++Array.interpolation(15)
~data=[];
~data=Array.fill(100, {arg i ; y.value(i/15)[1]});
~data.plot

Point.big(10,20)
~points[..100].collect({arg p; p.y}).plot
(
~intPoints = [];
~points[..100].do({
	arg p, i;
	var diff = ~points[i+1]-p;
	~intPoints = ~intPoints ++ Array.interpolation(diff.x, p.y, ~points[i+1].y);
});
(~intPoints[0..1024].as(Signal)*Signal.welchWindow(1024)).plot
)
Signal.welchWindow(1024).plot

~values.post;
~values.plot;
~values[..100].bSplineInt(~times[..100])
~values[..100].plot;

Point(2,3).asArray
Array.interpolation(5,3,10)

s.boot;
b = Buffer.alloc(s, 2048);
(~values[1024..(1024+1023)].as(Signal).normalizeTransfer()*Signal.hanningWindow(1024)).asWavetable;//.plot(/*loop:true, numChannels: 2*/);
b.loadCollection((~values[1024..(1024+1023)].as(Signal).normalizeTransfer()*Signal.hanningWindow(1024)).asWavetable);
b.play;
b.plot
{Osc.ar(b, freq:1000, mul:0.1)!2}.play;

(~values[..1023].as(Signal).normalizeTransfer()*Signal.hanningWindow(1024)).asWavetable.plot(/*loop:true, numChannels: 2*/);

~values[..1023].size.postln;

NetAddr.langPort
NetAddr.localAddr
Buffer.freeAll;
(
	var bufferMaker = {
		arg array, bufsize = 1024, server = Server.default;
		var amtBuffers = floor(array.size/bufsize);
		var bufferArray;

		bufferArray = Array.fill(amtBuffers, {
			arg index;
			var newBuffer = Buffer.alloc(server, bufsize*2);
			newBuffer.loadCollection(((
				array[(index.asInteger*bufsize)..((index.asInteger+1)*bufsize-1)])
				.as(Signal).normalizeTransfer()
				* Signal.hanningWindow(bufsize))
				.asWavetable);
			newBuffer;
		});

		bufferArray.postln;

	};

	bufferMaker.value(~values);
)
~values[..1024].plot;
(
Synth.new(\Diabetes, [\freq, 100, \detuneFactor, 1.5, \orderSize, 19, \bufferNum, 1, \velocity, 30, \flutter, 0.000001]);
Synth.new(\Diabetes, [\freq, 300, \detuneFactor, 1.5, \orderSize, 19, \bufferNum, 1, \velocity, 20, \flutter, 0.000001]);
Synth.new(\Diabetes, [\freq, 400, \detuneFactor, 1.5, \orderSize, 19, \bufferNum, 1, \velocity, 30, \flutter, 0.000001]);
Synth.new(\Diabetes, [\freq, 900, \detuneFactor, 1.5, \orderSize, 19, \bufferNum, 1, \velocity, 50, \flutter, 0.000001]);
)



(
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
)

s.reboot
(

Pbind.new(
  //\freq, Pseq([110, 125, 150, 100], 4), 
  \octave, 3,
  //\ctranspose, -7,
  \degree, Pseq([1, 2, 4, 0], 4),
  \dur, Pseq([0.25], 16)
).play
)


~electricBuffers = SoundFile.collectIntoBuffers(File.getcwd +/+ "../defs/media/normalized/*",  server: s);
File.getcwd
~scale=3;
~tonicScale = Scale.majorPentatonic;
~tonicScale.tuning(\just);
s.boot
(
x = Pbind(
  \instrument, \sliceBuffer,
  \attack, Pwhite(0.0,0.2,inf),
  \octave, 4,
  \degree, Prand([0,1,2,3,4,5], inf),
  \pan, Pwhite(-0.5,0.5,inf),
  \scale, ~tonicScale,
  \ctranspose, Pfunc({var flip=0.01.coin.asInteger;if(flip==1){"transpose!".postln;};flip*2;}),
  \release, Pseq([0.1, 0.1, 0.1, 0.5, 0.75, 0.8, 1.2, 1.5, 3]*~scale,inf),
  \resonantAmp, Pexprand(0.1,0.4,inf),
  \dur, Pseq(0.5*[0.25,0.25, 0.25],inf),
  \bufnum, Pfunc({~electricBuffers.choose})
).play(quant: 1);
)
~tonicScale.tuning_(\ET12)
~tonicScale.tuning_(\just)
~tonicScale.degreeToFreq(3, 130.813, 0);
10*(0.5.coin.asInteger)

Synth.new(\sliceBuffer, [\bufnum, ~electricBuffers.choose]);
(
x.stop;
s.queryAllNodes
)
s.freeAll

(
SynthDef.new(\sliceBuffer, {
  arg bufnum = 0, rate = 1, pan = 0, outBus = 0, amp = 0.5, attack = 0.01, release = 0.8, freq = 220, resonantAmp = 0.25;
  var signal = PlayBuf.ar(2, bufnum, rate*BufRateScale.kr(bufnum)/*, doneAction:Done.freeSelf*/);
  var delayTime = 1 / (freq);
  var resonator = CombL.ar(signal, delayTime, delayTime, release)*resonantAmp/*, doneAction:Done.freeSelf*/;
  var combined = (resonator+signal)*EnvGen.kr(Env.perc(attackTime: attack, releaseTime: release));
  var panner = LeakDC.ar(Balance2.ar(left: combined[0], right: combined[1],  pos: pan));
  DetectSilence.ar(panner,  time: 1,  doneAction: Done.freeSelf);

  //Använd detectsilence istället? env endast på resonans....
  Out.ar(outBus, Limiter.ar(panner, level: amp));
}).add;
)

[-10,1,2,3,4].normalize
