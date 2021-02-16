
/**
*
* Kod för att test-spela alla SynthDefs 
*
**/
(
	~booted = false;
	~slices = [];
	~buffers = List.new();
)
(
	Server.default.waitForBoot({
		var wavetable, jlc, drums, radioStretch;
		var order = [8, 28, 21, 3, 25, 13, 23, 1, 22, 29, 9, 2, 17, 5, 10, 7, 12, 4, 6, 27, 26, 19, 20, 14, 16, 24, 30, 18, 15, 11]; //TODO temporärt...

		var scale = Scale.majorPentatonic;


		if(~booted != true){
			Buffer.freeAll(s);
			~slices = SoundFile.collectIntoBuffers(File.getcwd +/+ "media/normalized/*",  server: Server.default);

			(File.getcwd +/+ "SynthDefs.sc").load(); //ladda Synth Defs

			~booted = true;

			 order.do({ 
				arg index, count;
				var url = format(File.getcwd +/+ "media/wavetable/sample_%.wav", index); 
				~buffers.add(Buffer.read(Server.default, path: url, numFrames: 1024)); 

			 });

			Server.default.sync;

        };

		~wavetable = Synth.new(\Diabetes, [\bufferNum, ~buffers[3].bufnum, \velocity, 126, \detuneFactor, 0.5, \freq, 110]);

		// TODO omvandla till pbind...!
		loop { |i| 
			drums = Synth.new(\sliceBuffer, [\bufnum, ~slices.choose.bufnum, \freq, scale.degreeToFreq(-10+20.rand, 220, 0), \release, rrand(10,50)/75.0, \resonantAmp, rrand(0,10)/10.0, \attack, rrand(0,50)/100.0]);
			[1/6, 1/8].wchoose([1,50].normalizeSum).wait;
		};

	});
)

~wavetable.set(\detuneFactor, 1.5)

//1.5, 1.25, 1.65, 1.01 (Schysst liten serie)

s.record;
s.stopRecording;

~slices
Server.default.freeAll;
Server.default.queryAllNodes;

Scale.directory

(

	SynthDef.new(\JLCBass, {
		var osc = SinOsc.ar(220, mul: 0.1);
		Out.ar(0, osc!2);
	}).add;

	Server.default.waitForBoot({
		var bass = Synth.new(\JLCBass);
		1.wait;
		bass.free;
	});

)
