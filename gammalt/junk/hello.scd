/**
*
* TODO: - read from midi file
*		- polyphony...
*		- 
*		- 
*
*
**/

(
	Server.default.options.inDevice = "Built-in Microph";
	Server.default.options.outDevice = "BTR011"; //for playing at home...
	Server.default.waitForBoot({
		var firstRoutine, secondRoutine;
		~firstScale = Scale.whole;
		~secondScale = Scale.shang;
		firstRoutine = Routine.new(
			{
				loop {
					{
						PanX.ar(2, SinOsc.ar(~firstScale.degreeToFreq(-5+13.rand, 220, 0), mul: 0.05)*EnvGen.kr(Env.perc(attackTime:0.001), doneAction: Done.freeSelf), pos: (2.0.rand-1.0));
					}.play;
					[1/3, 1/4, 1/5, 1/7].wchoose([8, 4, 1, 2].normalizeSum).yield;
				}
			};
		);
		firstRoutine.play(quant: 4);

		secondRoutine = Routine.new(
			{
				loop {
					{
						PanX.ar(2, SinOsc.ar(~secondScale.degreeToFreq(-10+19.rand, 275, 1), mul: 0.05)*EnvGen.kr(Env.perc(attackTime:0.001), doneAction: Done.freeSelf), pos: (2.0.rand-1.0));
					}.play;
					[1/3, 1/4, 1/5, 1/7].wchoose([8, 4, 1, 2].scramble.normalizeSum).yield;
				}
			};
		);
		secondRoutine.play(quant: 2);
	})
)
Scale.directory
~scale = Scale.phrygian
