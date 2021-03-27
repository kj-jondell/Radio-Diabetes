BloodGlucose {

	/*
	* Arguments:
	*	- scale: a Scale defining scale that will be played by this object
	*	- soundSource: a Symbol containing name of SynthDef associated to this object
	*/
	var server, cleanupFunction, electricBuffers, <>register, <>key, <>scale, <>position, <>soundSource, <>metaData, <player, <startTime = 0, isCleaned = false, >hasWaiting = false, localMinTime = 0;
	var <>typeOfFunction = "";
	var differentiated;
	classvar points, values, index;
	classvar debug = false;

    *new {
		arg server_, cleanup_, electricBuffers_;
		index = 0;
		values = List.new();
		points = List.new();

        ^super.newCopyArgs(server_, cleanup_, electricBuffers_);
	}

	/**
	*
	* creates interpolation so that the index number corresponds to time in minutes (i.ex. so values[index] is correct).
	*
	*/
	createInterpolated {
		arg startPoint = 0, endPoint = 100;
		var interpolatedPoints = [];
		points[startPoint..endPoint].do({
			arg currentPoint, currentIndex;
			var diff = points[currentIndex+1]-currentPoint;
			interpolatedPoints = interpolatedPoints ++ Array.interpolation(diff.x, currentPoint.y, points[currentIndex+1].y);
		});
		^interpolatedPoints;
	}

	wavetableCreator {
			arg array, bufsize = 1024, server = Server.default;
			var amtBuffers = floor(array.size/bufsize);
			var bufferArray;

			bufferArray = Array.fill(amtBuffers, {
				arg index;
				var newBuffer = Buffer.alloc(server, bufsize*2);
				newBuffer.loadCollection(((
					array[(index.asInteger*bufsize)..((index.asInteger+1)*bufsize-1)])
					.as(Signal).normalizeTransfer()
					* Signal.hanningWindow(bufsize))
					.asWavetable);
				newBuffer; //returns newbuffer to array
			});

			^bufferArray;
			//bufferArray.postln;
	}

	plot {
		{
			points.collect({arg i; i.y;}).plot;
			points.collect({arg i; i.x;}).plot;
		}.defer;
	  ///values.plot;
	}

	/**
	*
	* Adds new value received from OSC
	*
	*/
	addPoint {
		arg x, y;
		points = points.add(Point.new(x,y));
	}

	/*
	*
	* Adds new value received from OSC
	*
	*/
	addValue {
		arg value;
		values = values.add(value);
	}

	/**
	* TODO: reconsider... Tuning should possibly be defined in Scale-object assigned to this object.
	*/
	setTuning {
		arg tuning;
		this.scale.tuning_(tuning);
	}

	/*
	*
	* Private recursive function to calculate n:th order differentiated array.
	*
	*/
	prGetDifferentiated {
		arg array, order = 1, scale = 1.0, step = 0;
		var differentiated = (array[..array.size-1]-array[1..])/scale;
		if(step<order)
			{step = step + 1; ^this.prGetDifferentiated(differentiated, order, scale, step);}
			{^differentiated;}
	}

	/**
	* TODO rename? 
	*/
	createPatterns {
		arg repeats = inf;

		values = points.collect({arg point; point.y}); //behåll (viktig!)

		differentiated = this.prGetDifferentiated(values, order: 1, scale: 5); //behåll?

		metaData = Dictionary.newFrom([\mean, values.mean, \max, values.maxItem, \min, values.minItem, \stdDev, values.stdDev, \variance, values.variance, \geoMean, values.geoMean, \autocorr, values.autocorr]); //TODO räkna ut allt på en gång eller när det används?
	}

	/*
	* Returns whether object played min time
	*/
	minTimePassed {
	  ^((player.clock.seconds-startTime)>localMinTime);
	}

	cleanup {
		arg fadeOut = 10;
		player.xstop(fadeOut);
		if(isCleaned == false){
			cleanupFunction.value(this);
			isCleaned = true;
		};
	}

	prCallback {
		arg maxTime, fadeOut;
		  if(maxTime>0){
			  if(player.clock.seconds-startTime>maxTime){
				  this.cleanup(fadeOut);
			  } {
				  if((player.clock.seconds-startTime)>localMinTime){
					  if (hasWaiting) { 
						  this.cleanup(fadeOut);
					  }
				  }
			  }
		  };

	}

	/*
	* TODO: change the content of this Pbind...
	*/
	play {
		//TODO definiera dessa när objekt skapas?
		arg fadeIn = 10, maxTime = 10, minTime = 0, fadeOut = 10, instrument = \sliceBuffer;

		var scale = Scale.majorPentatonic;
		scale.tuning(\just);

		localMinTime = minTime;

		player = Pbind.new ( //electric buffers
				   \instrument, instrument,
				   \attack, Pwhite(0.0,0.2,inf),
				   \bufnum, Pfunc.new({electricBuffers.choose.bufnum;}), //TODO ÄNDRA DETTA!!!!!!!!
				   \degree, Pseq.new(values.linlin(1, 30, 0, 20).round(),  repeats: inf), //omfång..? 
				   \mtranspose, 4.rand*5-10,
				   \ctranspose, Pfunc({0.02.coin.asInteger*2}), // är detta ok... ?? låta metadata styra sannolikheten??
				   \release, Pseq(differentiated.normalize*3.9+0.1, inf), //TODO använda någon annan signal kanske?
				   \pan, 2.0.rand-1.0, 
				   \resonantAmp, Pexprand(0.1,0.4,inf),
				   \scale, scale,
				   \callback, {this.prCallback(maxTime, fadeOut);},
				   \server, server, //TODO VIKTIG!!
				   \dur, Pwrand.new([1/4, 1/8/*, 1/16, Rest(1/4)*/], [6, 2/*, 0.5, 1*/].normalizeSum, inf) 
		   	 )
		.asEventStreamPlayer.xplay(fadeIn, quant: 1);
		startTime = player.clock.seconds;
	}

	printOn {
		arg stream;
		stream << "BloodGlucose( " << values << " )";
	}

	/**
	* TODO IMPLEMENT
	*/
	futurePlay {
	  var bufnum, numFrames, parA, parB;
	  bufnum = ~buffer.bufnum;
	  numFrames = ~buffer.numFrames;
	  parA = Pbind.new(
		\instrument, \inductionSelf,
		\bufnum, bufnum,
		\numFrames, numFrames,
		\pan, -0.1,
		\stutter, Pwrand([1,2,3], [10,1,1].normalizeSum, inf),
		\freq, (Pwrand([99.34, 132.60, [198.67, 265.2, 2*148.83], 148.83], [5, 1, 0.05, 1].normalizeSum, inf)*Pwrand([440, 446]/446, [3, 10].normalizeSum, inf)).stutter(Pkey(\stutter)),//*(132.6/99.34),
		\start, (Pwrand([0.01, 0.25, 0.3, 0.45,/* 0.5,*/ 0.67/*, 0.94*/], [5, 8, 1, 2, 3].normalizeSum, inf)+Pwhite(-0.01, 0.01, inf)).stutter(Pkey(\stutter)),
		\attack, Pwhite(0.0, 0.001, inf),
		\level, Pfunc{
		  arg event; 
		  if(event[\freq].size > 1)
		  {0.35;}
		  {event[\freq]/(148.83)}
		},
		\strum, 0.099,
		\release, (2*Pkey(\start)).clip(0.75,1.75)*Pwrand([0.5, 1.5, 3, 0.75, 5], [10, 10, 3, 7, 0].normalizeSum, inf),
		\cutoffFactor, Pwhite(4, 14, inf),
		\dur, Pfunc{
		  arg event; 
		  if(event[\freq].size > 1)
		  {1/3}
		  {1/8}
		}

	  );
	  parB = Pbind.new(
		\instrument, \inductionSelf,
		\bufnum, bufnum,
		\numFrames, numFrames,
		\pan, 0.1,
		\freq, Pwrand([99.34, 132.60, 198.67, 148.83], [0.1, 5, 5, 1].normalizeSum, inf)*Pwrand([440, 446]/446, [1, 10].normalizeSum, inf),//*(132.6/99.34),
		\start, Pwrand([/*0.01,*/ 0.25, 0.3, 0.45,/* 0.5,*/ 0.67, 0.94], [8, 1, 5, 2, 1].normalizeSum, inf)+Pwhite(-0.0125, 0.0125, inf),
		\attack, Pwhite(0.0, 0.02, inf),
		\level, Pkey(\freq)/(148.83*2.5),
		\cutoffFactor, Pwhite(3, 7, inf),
		\release, Pwrand([0.5, 1.5, 3, 0.75, 5]*1.4, [10, 10, 0, 7, 0].normalizeSum, inf),
		\dur, 1/5
	  );
	  //parA.play;
	  Ppar([parA, parB]).play;
	}

	/**
	* TODO IMPLEMENT
	*/
	futurePlay2 {
		arg gsmBuffer;
		var synth, pattern;
		synth = Synth.new(\rockingGSM, [\attack, 25, \pan, 0, \amp, 1.2, \freq, 130, /*\freq2, 110*1.5, \freq3, 110*0.75,*/ \bufnum, gsmBuffer.bufnum], target: server);

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

	}
/**
	* TODO IMPLEMENT
	*/
	futurePlay3 {
		/* TODO FLYTTA DETTA TILL BLOOD GLUCOSE KLASS */
//		var array = newDataPack.wavetableCreator(newDataPack.createInterpolated(0,500), 1024, server);
//
//		/**
//		*
//		* TODO gör om till pbind...
//		*
//		*/
//		Routine.run{
//			server.sync;
//			3.do({
//				Synth.new(\Diabetes, [\freq, Scale.majorPentatonic.degreeToFreq(10.rand, 110, 0), \detuneFactor, 1.5, \orderSize, array.size, \velocity, 30, \flutter, 0.000001, \bufferNum, array[0].bufnum], target: server);
//			});
//		};
	}
}
