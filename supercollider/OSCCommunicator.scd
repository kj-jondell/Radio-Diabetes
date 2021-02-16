var dataPackets = List.new();
var newDataPack;

var oscFunc = {

	arg msg, time, addr, recvPort;

	switch(msg[0],
		'/newPackage', {newDataPack = BloodGlucose.new();}, 
		'/value', {newDataPack.addValue(msg[1]);},
		'/meta', {
		  newDataPack.metaData = Dictionary.newFrom(msg[1..]);
		  newDataPack.metaData.postln;
		},
		'/valueDone', {
		  newDataPack.createPatterns();
		  dataPackets.add(newDataPack);
		}
	);

};
// ---------- SERVER SETTINGS ---------- 
var server, serverOptions = ServerOptions.new;

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

server = Server.new(\diabetesServer,  NetAddr("localhost", 58009),  options: serverOptions); // non-standard server port!

SynthDescLib.global.addServer(server);
thisProcess.addOSCRecvFunc(oscFunc);

server.boot;
