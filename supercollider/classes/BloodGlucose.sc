BloodGlucose {

	/*
	* Arguments:
	*	- scale: a Scale defining scale that will be played by this object
	*	- soundSource: a Symbol containing name of SynthDef associated to this object
	*/
	var server, cleanupFunction, <>register, <>key, <>scale, <>position, <>soundSource, <>metaData, <player, <startTime = 0, isCleaned = false, >hasWaiting = false, localMinTime = 0;
	var <>typeOfFunction = "";
	classvar values, index, rawPattern, differentiatedPattern;
	classvar debug = false;

    *new {
		arg server_, cleanup_;
		index = 0;
		values = List.new();

        ^super.newCopyArgs(server_, cleanup_);
	}

	/*
	*
	* Adds new value received from OSC
	*
	*/
	addValue {
		arg value;
		values.add(value);
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
		arg repeats = 12;
		var differentiated = this.prGetDifferentiated(values, order: 1, scale: 5); 

		rawPattern = Pseq.new(values.round(), repeats);
		differentiatedPattern = Pseq.new(differentiated, repeats);

		metaData = Dictionary.newFrom([\mean, values.mean, \max, values.maxItem, \min, values.minItem, \stdDev, values.stdDev, \variance, values.variance, \geoMean, values.geoMean, \autocorr, values.autocorr]); //TODO räkna ut allt på en gång eller när det används?

		metaData[\mean].postln;
		metaData[\variance].postln;
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
		arg fadeIn = 10, maxTime = 10, minTime = 0, fadeOut = 10, instrument = \sliceBuffer;

		localMinTime = minTime;

		player = Pn( 
		    Plazy {
		   	 Pbind.new(
		   		 \instrument, instrument,
		   		 \bufnum, Prand.new([1,2,3,4,5,6,7,8,9], 100),
		   		 \degree, rawPattern,
		   		 \octave, metaData[\mean].linlin(7.0, 13.0, 0, 2).round(),
		   		 \pan, metaData[\variance].linlin(5.0,15.0,-1.0,1.0), //differentiatedPattern,
		   		 \scale, Scale.majorPentatonic,
		   		 \callback, {this.prCallback(maxTime, fadeOut);},
		   		 \server, server, //TODO VIKTIG!!
		   		 \dur, Pwrand.new([1/4, 1/8/*, 1/16, Rest(1/4)*/], [6, 2/*, 0.5, 1*/].normalizeSum, 10) 
		   	 )
		    }, inf)
		.asEventStreamPlayer.xplay(fadeIn, quant: 1);
		startTime = player.clock.seconds;
	}

	printOn {
		arg stream;
		stream << "BloodGlucose( " << values << ", " << rawPattern <<" )";
	}

}
