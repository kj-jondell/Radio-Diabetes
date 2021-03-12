b = NetAddr.new("192.168.0.104", 5000);

//"hello!".postln;
b.sendMsg("/filter", "from supercollider");

NetAddr.langPort.postln;

thisProcess.addOSCRecvFunc({
    arg ...args;
    args.postln;

    b.sendMsg("/filter", "form supercollider");
});
