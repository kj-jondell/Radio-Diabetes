/**
*
* TODO: 1. Rita upp logik och utforma unit-tester (för kön...)
*       2. Glöm inte att alltid ange vilken server som ska spela upp vad...
*       3. 
*       4. 
*       5. 
*       6. 
*
*/

var debug_ = false;

var dataPackets = List.new(), enqueuedPackets = List.new();
var newDataPack;
var maxConcurrentObjects = 3;

// ---------- SERVER SETTINGS ---------- 
var server, serverOptions = ServerOptions.new;

var serverPort = 58009;

// ---------- SOUND SETTINGS ---------- 
var greetingBuffers, electricBuffers;

var setWaiting = {
	arg waiting = true;
	dataPackets.do({
		arg object;
		object.hasWaiting = waiting;
	});
};

var deleteCallback = {
	arg object;
	dataPackets.remove(object);
	// if queue size > 0, pop item from queue and add to playing stack
	if(enqueuedPackets.size() > 0){
		var newFromQueue = enqueuedPackets.pop();
		newFromQueue.play(buffers:  electricBuffers, maxTime: 200, minTime: 40, fadeIn: 4, fadeOut: 4, instrument: [/*\sliceBuffer, */\sin].choose, octave: 2.rand);
		dataPackets.add(newFromQueue);
	};
	if(enqueuedPackets.size() == 0){
		setWaiting.value(false); //
	};
};
// ---------- OSC DEF ---------- 

var oscFunc = {

	arg msg, time, addr, recvPort;

	switch(msg[0],
		'/newPackage', {newDataPack = BloodGlucose.new(server, deleteCallback);}, 
		'/point', {newDataPack.addPoint(msg[2], msg[1]);}, // punkt = tid, värde
		'/valueDoneDebug', {
			var array = newDataPack.wavetableCreator(newDataPack.createInterpolated(0,500), 1024, server);

			Routine.run{
				server.sync;
				3.do({
					Synth.new(\Diabetes, [\freq, Scale.majorPentatonic.degreeToFreq(10.rand, 110, 0), \detuneFactor, 1.5, \orderSize, array.size, \velocity, 30, \flutter, 0.000001, \bufferNum, array[0].bufnum], target: server);
				});
			};

		},
		'/valueDone', {
		  { // TODO göra en annan funktion för att spela upp hälsningsmeddelanden...
			  var bufnum = greetingBuffers.choose.bufnum;
			  PlayBuf.ar(1, bufnum: bufnum, rate: BufRateScale.kr(bufnum), doneAction: Done.freeSelf)!2
		  }.play(target: server);

		  newDataPack.createPatterns();
          // if playing stack is full, enqueue new packet
		  if(dataPackets.size<maxConcurrentObjects){
			  newDataPack.play(buffers: electricBuffers, maxTime: 0, minTime: 40, fadeIn: 10, fadeOut: 10, instrument: [\sliceBuffer/*, \sin*/].choose, octave: 4.rand*5-20); // vissa får maxtime bestämd, vissa får obestämd...
			  dataPackets.add(newDataPack);
			}
			{
				//loop through playing objects, if
				enqueuedPackets.add(newDataPack);

				block {
					arg break;
					dataPackets.do({
						arg object;
						if(object.minTimePassed()){
							object.cleanup(fadeOut: 10);
							break.value();
						}
					});

					setWaiting.value(); 
				};
				//"max".postln;
				//dataPackets.size.postln;
			};
		}
	);

};

if(debug_ == false){
  serverOptions.device = "scjack:supercollider";
  serverOptions.numInputBusChannels = 0;

  "SC_JACK_DEFAULT_INPUTS".setenv();
  "SC_JACK_DEFAULT_OUTPUTS".setenv("diabetes-radio"); 
};

server = Server.new(\diabetesServer,  NetAddr("localhost", serverPort),  options: serverOptions); // non-standard server port!

SynthDescLib.global.addServer(server);
thisProcess.addOSCRecvFunc(oscFunc);

//OSCFunc.trace(true);

Require("defs/SynthDefs");
server.waitForBoot({
    electricBuffers = SoundFile.collectIntoBuffers(File.getcwd +/+ "defs/media/normalized/*",  server: server);
	greetingBuffers = SoundFile.collectIntoBuffers(File.getcwd +/+ "/media/tack/*", server: server);

    server.sync;

	"playing...".postln;
	Synth.new(\sin, [\freq, 110+30.rand], target: server);
    "Done!".postln;
});

