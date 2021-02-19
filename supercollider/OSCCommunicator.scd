// Quarks.install(File.getcwd +/+ "classes"); // needs to be recompiled..., only needs to be added once...
// Quarks.clear
// thisProcess.recompile;
// (
//     LanguageConfig.addIncludePath(File.getcwd +/+ "/classes");
//     LanguageConfig.store(File.getcwd +/+ "sclang_conf.yaml");
// )
var dataPackets = List.new();
var newDataPack;

var oscFunc = {

	arg msg, time, addr, recvPort;

	switch(msg[0],
		'/newPackage', {newDataPack = BloodGlucose.new();}, 
		'/value', {newDataPack.addValue(msg[1]);},
		'/meta', {
		  newDataPack.metaData = Dictionary.newFrom(msg[1..]);
		  //newDataPack.metaData.postln;
		},
		'/valueDone', {
		  newDataPack.createPatterns();
          newDataPack.play();
		  dataPackets.add(newDataPack);
          Synth.new(\sin, [\freq, 220]);
		}
	);

};
// ---------- SERVER SETTINGS ---------- 
var server, serverOptions = ServerOptions.new;

var serverPort = 58009;

/* TODO ta bort hjälp-synthDef */
SynthDef.new(\sin,  {
	arg freq;
	var sinOsc = SinOsc.ar(freq, mul:0.1)*EnvGen.kr(Env.perc(), doneAction: Done.freeSelf);
	Out.ar(0, sinOsc!2);
}).add;

serverOptions.device = "scjack:supercollider";
serverOptions.numInputBusChannels = 0;

"SC_JACK_DEFAULT_INPUTS".setenv();
"SC_JACK_DEFAULT_OUTPUTS".setenv("darkice-piano"); //TODO change name of darkice-jack node

server = Server.new(\diabetesServer,  NetAddr("localhost", serverPort),  options: serverOptions); // non-standard server port!

SynthDescLib.global.addServer(server);
thisProcess.addOSCRecvFunc(oscFunc);

Require("defs/SynthDefs");
server.waitForBoot({
    SoundFile.collectIntoBuffers(File.getcwd +/+ "defs/media/normalized/*",  server: server);

    server.sync;

    2.do({
        arg i;
        Synth.new(\sliceBuffer, [\freq, 220]);
        Synth.new(\sin, [\freq, 220]);
        1.wait;
    });

    server.status;
    "Done!".postln;
});

