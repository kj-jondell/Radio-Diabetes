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

var debug_ = false; // denna variabel styr om jag kör från min mac ("true") eller ubuntu ("false")

var dataPackets = List.new(), enqueuedPackets = List.new();
var newDataPack;
var maxConcurrentObjects = 3;

// ---------- SERVER SETTINGS ---------- 
var server, serverOptions = ServerOptions.new;

var serverPort = 58009;

// ---------- SOUND SETTINGS ---------- 
var greetingBuffers, electricBuffers, gsmBuffer;

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
		newFromQueue.play(maxTime: 200, minTime: 40, fadeIn: 4, fadeOut: 4, instrument: \sin);
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
		'/newPackage', {newDataPack = BloodGlucose.new(server, deleteCallback, electricBuffers);}, 
		'/point', {newDataPack.addPoint(msg[2], msg[1]);}, // punkt = tid, värde
		'/valueDoneDebug', {
		  /* TODO FLYTTA DETTA TILL BLOOD GLUCOSE KLASS */
			var array = newDataPack.wavetableCreator(newDataPack.createInterpolated(0,500), 1024, server);

			Routine.run{
				server.sync;
				3.do({
					Synth.new(\Diabetes, [\freq, Scale.majorPentatonic.degreeToFreq(10.rand, 110, 0), \detuneFactor, 1.5, \orderSize, array.size, \velocity, 30, \flutter, 0.000001, \bufferNum, array[0].bufnum], target: server);
				});
			};

		},
		'/valueDone', {
		  { // TODO göra en annan funktion för att spela upp hälsningsmeddelanden... och flytta. koden.!
			  var bufnum = greetingBuffers.choose.bufnum;
			  PlayBuf.ar(1, bufnum: bufnum, rate: BufRateScale.kr(bufnum), doneAction: Done.freeSelf)*0.5!2
			  /// TODO panna meddelandet från samma plats som synth spelas upp...
		  }.play(target: server);

		  newDataPack.createPatterns();
          // if playing stack is full, enqueue new packet
		  if(dataPackets.size<maxConcurrentObjects){
			  newDataPack.play(maxTime: 0, minTime: 40, fadeIn: 10, fadeOut: 10, instrument: \sliceBuffer); 
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
			};
		}
	);

};

if(debug_ == false){
  serverOptions.device = "scjack:supercollider";
  serverOptions.numInputBusChannels = 0;
  serverOptions.verbosity = -1;

  "SC_JACK_DEFAULT_INPUTS".setenv();
  "SC_JACK_DEFAULT_OUTPUTS".setenv("diabetes-radio"); 
};

server = Server.new(\diabetesServer,  NetAddr("localhost", serverPort),  options: serverOptions); // non-standard server port!

SynthDescLib.global.addServer(server);
thisProcess.addOSCRecvFunc(oscFunc);

//OSCFunc.trace(true);

Require("defs/SynthDefs");
server.waitForBoot({
  var synth, pattern; //TODO Temp...
    electricBuffers = SoundFile.collectIntoBuffers(File.getcwd +/+ "defs/media/normalized/*",  server: server);
	greetingBuffers = SoundFile.collectIntoBuffers(File.getcwd +/+ "/media/tack/*", server: server);
	gsmBuffer = Buffer.read(server, File.getcwd +/+ "media/monoGSM.wav");

    server.sync;

	"playing...".postln;
	Synth.new(\sin, [\freq, 110+30.rand], target: server);

	// TODO FLYTTA KOD
	synth = Synth.new(\rockingGSM, [\attack, 25, \pan, 0, \amp, 1.2, \freq, 130, /*\freq2, 110*1.5, \freq3, 110*0.75,*/ \bufnum, gsmBuffer.bufnum], target: server);

	//// TODO FLYTTA KOD
 	pattern = Penvir(
	  (formant: FormantTable.get(FormantTable.keys().choose)),
	  Pbind(
		\type, \set,
		\id, synth.nodeID,
		\args, #[\stretch, \freq, \freqs, \amps, \q, \formantPan, \freq2, \freq3, \pan],
		\freq, Pseq([1.1, 1.25, 1.5, 1]*131, inf),
		\dur, Pwrand.new([1.5, 1, 1.25, 1.75]*2,  weights: [1, 3, 1, 0].normalizeSum,  repeats: inf/*4*64*/),
		\formant, Pfunc({~formant = FormantTable.get(FormantTable.keys().choose)}),
		\freqs, Pfunc({[~formant[0]]}),
		\amps, Pfunc({[~formant[1]]}),
		\q, Pfunc({[~formant[2]]}),
		 \freq2, (Pkey(\freq)*Prand([0.5, 1, 2], inf)),
		 \freq3, (Pkey(\freq)*Prand([3/4, 4/3, 1.5], inf)),
		 \server, server,
		\formantPan, Pwhite.new(lo: -0.25,  hi: 0.25,  length: inf)
	  )
	).play(quant: 1);
    "Done!".postln;
});

