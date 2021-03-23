// TODO Dennis Smalley - undersök
(
Server.default.waitForBoot({
	var object = BloodGlucose.new;
	var routine = 
		Routine({
			loop {
				object.play();
				[1/6.6, 1/6.8, 1/7.4, 1/7.8, 1/7.6, 1/6.8, 1/6.1, 1/5.8, 1/6, 1/6.4, 1/6.8, 1/6.9, 1/7, 1/7.2, 1/7.2, 1/7.1, 1/7.3, 1/7.8, 1/8.1, 1/8, 1/7.9, 1/7.8, 1/7.8, 1/8.1, 1/8.2, 1/8.2, 1/8.4, 1/8.3, 1/8.2, 1/8.9, 1/9, 1/8.8, 1/8.8, 1/8.8, 1/8.8, 1/8.9, 1/9.1, 1/9.3, 1/8.9, 1/7.9, 1/7.7, 1/7.3, 1/6.6, 1/5.6, 1/4.7, 1/4.1, 1/4.2, 1/5.5, 1/6.6, 1/7.2, 1/7.5, 1/7.2, 1/6.9, 1/7.3, 1/7.8, 1/7.5, 1/7].choose.yield; // TODO mappa 1/mätdata
			};
		});

	/**
	* Temporary helper definition
	*/
	SynthDef.new(\sinHelper, {
		arg freq = 220, vol = 0.1;
		var signal = SinOsc.ar(freq, mul: 0.03*(vol**2.0));
		var env = EnvGen.ar(Env.perc(attackTime: 0.01, releaseTime: 1.5*vol), doneAction: Done.freeSelf);
		var outSignal = PanX.ar(2, in: signal*env, pos: Rand(0.0, 1.0));
		Out.ar(0, outSignal);
	}).add;

	Server.default.sync; //to make sure synthdef is properly loaded..

	object.scale = Scale.neapolitanMajor; //Scale.yu;
	object.setTuning(\just);
	object.soundSource = 'sinHelper';
	routine.play;

});
)

Server.default.queryAllNodes;
Scale.directory

(
	var rec = Recorder(Server.default);
	rec.record(numChannels: 2);
)
