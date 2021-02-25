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

// (
//     LanguageConfig.addIncludePath(File.getcwd +/+ "/classes");
//     LanguageConfig.store(File.getcwd +/+ "sclang_conf.yaml");
// )

var dataPackets = List.new(), enqueuedPackets = List.new();
var newDataPack;
var maxConcurrentObjects = 3;

// ---------- SERVER SETTINGS ---------- 
var server, serverOptions = ServerOptions.new;

var serverPort = 58009;

var deleteCallback = {
	arg object;
	dataPackets.remove(object);
	// if queue size > 0, pop item from queue and add to playing stack
	if(enqueuedPackets.size()>0){
		var newFromQueue = enqueuedPackets.pop();
		newFromQueue.play(maxTime: 20, minTime: 4, fadeIn: 4, fadeOut: 4, instrument: [/*\sliceBuffer, */\sin].choose);
		dataPackets.add(newFromQueue);
	}
};
// ---------- OSC DEF ---------- 

var oscFunc = {

	arg msg, time, addr, recvPort;

	switch(msg[0],
		'/newPackage', {newDataPack = BloodGlucose.new(server, deleteCallback);}, 
		'/value', {newDataPack.addValue(msg[1]);},
		'/meta', {
		  newDataPack.metaData = Dictionary.newFrom(msg[1..]); // TODO ta bort helt? 
		},
		'/valueDone', {
		  newDataPack.createPatterns();
          // if playing stack is full, enqueue new packet
		  if(dataPackets.size<maxConcurrentObjects){
			  newDataPack.play(maxTime: 20, minTime: 4, fadeIn: 10, fadeOut: 10, instrument: [\sliceBuffer, \sin].choose); // vissa får maxtime bestämd, vissa får obestämd...
			  dataPackets.add(newDataPack);
			}
			{
				//loop through playing objects, if
				dataPackets.do({
					arg object;
					object.hasWaiting = true;
				});
				enqueuedPackets.add(newDataPack);
				"max".postln;
				dataPackets.size.postln;
			}
		}
	);

};

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

