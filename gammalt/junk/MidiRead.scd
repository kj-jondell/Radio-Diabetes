/**
*
* TODO: - currently doesn't loop correctly (overlaps with itself...)
*
*
**/

(
	(
		SynthDef( "organ", { |freq = 440, sustain = 1, amp = 0.1|
				var sig;
				sig = SinOsc.ar( freq, mul: amp );
				Out.ar( 0, Env([0,1,1,0], [0.025,sustain,0.025]).kr(2) * sig.dup )
		}).add;
	);
)
(
	m = SimpleMIDIFile.read("midi-resources/chords.mid");
	//Pn(m.p(\organ), inf);
	m.timeMode_('seconds')
	m.p.asStream.play

)
Server.default.boot
