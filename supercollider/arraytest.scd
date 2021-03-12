(
var randValues2 = Array.fill(100, {arg i; 2.0+28.0.rand;});
~randValues2.bSplineInt(1,10)
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
~values = Array.new();
(
thisProcess.removeOSCRecvFunc(f);
f = { |msg, time, addr|
    if(msg[0] == '/value') {
		~values.add(msg);
        "%".postf(msg[1]);
    }
};
thisProcess.addOSCRecvFunc(f);
)

~values.as(Signal).plot;

~values.postln;

NetAddr.langPort
NetAddr.localAddr
