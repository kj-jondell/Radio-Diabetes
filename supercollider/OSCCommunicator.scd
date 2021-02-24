/**
*
* TODO: 1. 
*       2. Glöm inte att alltid ange vilken server som ska spela upp vad...
*       3. 
*       4. 
*       5. 
*       6. 
*
*/

// Quarks.install(File.getcwd +/+ "classes"); // needs to be recompiled..., only needs to be added once...
// Quarks.clear
// thisProcess.recompile;
// (
//     LanguageConfig.addIncludePath(File.getcwd +/+ "/classes");
//     LanguageConfig.store(File.getcwd +/+ "sclang_conf.yaml");
// )

var dataPackets = List.new();
var newDataPack;

// ---------- SERVER SETTINGS ---------- 
var server, serverOptions = ServerOptions.new;

var serverPort = 58009;

var deleteCallback = {
  arg ...args;
  args.postln;
  "HELLO!".postln;
};
// ---------- OSC DEF ---------- 

var oscFunc = {

	arg msg, time, addr, recvPort;

	switch(msg[0],
		'/newPackage', {newDataPack = BloodGlucose.new(server, deleteCallback);}, 
		'/value', {newDataPack.addValue(msg[1]);},
		'/meta', {
		  newDataPack.metaData = Dictionary.newFrom(msg[1..]);
		  //newDataPack.metaData.postln;
		},
		'/valueDone', {
		  newDataPack.createPatterns();
          newDataPack.play();
		  dataPackets.add(newDataPack);
		}
	);

};

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

//OSCFunc.trace(true);

Require("defs/SynthDefs");
server.waitForBoot({
    SoundFile.collectIntoBuffers(File.getcwd +/+ "defs/media/normalized/*",  server: server);

    server.sync;

	"playing...".postln;
	Synth.new(\sin, [\freq, 110+30.rand], target: server);
    "Done!".postln;
});

