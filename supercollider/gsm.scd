(
	SynthDef.new(\rockingGSM, {
		arg freq = 110, pan = 0;
		var signal = PlayBuf.ar(1,  rate: freq/155.0/*,  trigger: 1.0*/, loop: 1,  doneAction: Done.freeSelf);
		signal = Pan2.ar(signal, pos: pan);
		Out.ar(0, signal);
	}).add;
)
Server.default.freeAll
Server.default.meter
(
Server.default.waitForBoot({
	var synth, synthKvint, synthSept;
	//Buffer.read(Server.default, "häftigGSM.wav");

	//Server.default.record;

	synth = Synth.new(\rockingGSM, [\pan, 0.25]);
	synthKvint = Synth.new(\rockingGSM, [\freq, 110*1.5, \pan, -0.25]);
	synthSept = Synth.new(\rockingGSM, [\freq, 110*2, \pan, -0.5]);

	([110,125,150,100].wrapExtend(4*32)).do({
		arg i;
		synth.set(\freq, i/2*[2,1,0.5].wchoose([1,8,2].normalizeSum));
		synthKvint.set(\freq, i*0.75*[2,1,0.5].wchoose([1,10,0].normalizeSum));
		synthSept.set(\freq, i*[2,1,0.5].wchoose([0,5,3].normalizeSum));
		[1.5,1,1.25,1.75].wchoose([1,3,1,1].normalizeSum).wait;
	});

	synth.free;
	synthKvint.free;
	synthSept.free;

	//Server.default.stopRecording;

});
)
