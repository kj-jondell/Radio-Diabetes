BloodGlucose {

	/*
	* Arguments:
	*	- scale: a Scale defining scale that will be played by this object
	*	- soundSource: a Symbol containing name of SynthDef associated to this object
	*/
	var server, cleanupFunction, <>register, <>key, <>scale, <>position, <>soundSource, <>metaData, <player, <startTime = 0, isCleaned = false, >hasWaiting = false, localMinTime = 0;
	var <>typeOfFunction = "";
	classvar points, values, index, rawPattern, differentiatedPattern;
	classvar debug = false;

    *new {
		arg server_, cleanup_;
		index = 0;
		values = List.new();
		points = List.new();

        ^super.newCopyArgs(server_, cleanup_);
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

	/*
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

	/*
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

	/*
	* TODO rename?
	*/
	createPatterns {
		arg repeats = inf;
		var differentiated;

		values = points.collect({arg point; point.y});

		differentiated = this.prGetDifferentiated(values, order: 1, scale: 5); 

		rawPattern = Pseq.new(values.round(), repeats);
		differentiatedPattern = Pseq.new(differentiated, repeats);

		metaData = Dictionary.newFrom([\mean, values.mean, \max, values.maxItem, \min, values.minItem, \stdDev, values.stdDev, \variance, values.variance, \geoMean, values.geoMean, \autocorr, values.autocorr]); //TODO räkna ut allt på en gång eller när det används?

		if(debug){
			[values.mean,values.maxItem,values.minItem,values.stdDev,values.variance,values.geoMean,values.autocorr].do({
				arg value;
				value.postln;
			});

			server.postln;
		}
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
		arg buffers, fadeIn = 10, maxTime = 10, minTime = 0, fadeOut = 10, octave = 0, instrument = \sliceBuffer;
		//var octave = metaData[\mean].linlin(7.0, 13.0, 0, 2).round();

		//var root = 2.rand*5-10;

		var scale = Scale.majorPentatonic;
		scale.tuning(\just);

		localMinTime = minTime;

		player = // Pn( 
		    //Plazy {
		   	 Pbind.new(
		   		 \instrument, instrument,
		   		 \bufnum, Pfunc.new({buffers.choose.bufnum;}), //TODO ÄNDRA DETTA!!!!!!!!
		   		 \degree, rawPattern,
		   		 \octave, 4.rand+1,
				 //Scale.majorPentatonic
		   		 \pan, 2.0.rand-1.0, //differentiatedPattern,
				 \resonantAmp, Pwhite.new(0,2.0, inf),
				 \release, Pwhite.new(0.5,1.5, inf),
		   		 \scale, scale,
		   		 \callback, {this.prCallback(maxTime, fadeOut);},
		   		 \server, server, //TODO VIKTIG!!
		   		 \dur, Pwrand.new([1/4, 1/8/*, 1/16, Rest(1/4)*/], [6, 2/*, 0.5, 1*/].normalizeSum, inf) 
		   	 )
		    //}, inf)
		.asEventStreamPlayer.xplay(fadeIn, quant: 1);
		startTime = player.clock.seconds;
		{server.meter;}.defer;
	}

	printOn {
		arg stream;
		stream << "BloodGlucose( " << values << ", " << rawPattern <<" )";
	}

}
