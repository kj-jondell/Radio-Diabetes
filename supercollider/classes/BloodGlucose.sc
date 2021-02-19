BloodGlucose {

	/*
	* Arguments:
	*	- scale: a Scale defining scale that will be played by this object
	*	- soundSource: a Symbol containing name of SynthDef associated to this object
	*/
	var <>register, <>key, <>scale, <>position, <>soundSource, <>metaData;
	classvar values, index, rawPattern, differentiatedPattern;

    *new {
		index = 0;
		values = List.new();
        ^super.newCopyArgs();
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
		arg repeats = 4;
		var differentiated = this.prGetDifferentiated(values, order: 1, scale: 5); 

		rawPattern = Pseq.new(values, repeats);
		differentiatedPattern = Pseq.new(differentiated, repeats);

		//values.postln;
		//differentiated.postln;
        values.stdDev;
		[values.mean,values.maxItem,values.minItem,values.stdDev,values.variance,values.geoMean,values.autocorr].do({
            arg value;
            value.postln;
        });

		//differentiated.plot();
	}

	/*
	* TODO: change the content of this Pbind...
	*/
	play {
		 Pbind.new(
//			\instrument, \sliceBuffer,
//			\bufnum, Prand.new([1,2,3,4,5,6,7,8,9], 30),
		 	\degree, Pfunc.new({values.choose.round()}),
			\octave, 1,
			//\pan, differentiatedPattern,
			\scale, Scale.majorPentatonic,
			\dur, Pwrand.new([1/4, 1/8], [10, 1].normalizeSum, 30) 
		 ).play(quant: 1);
	}

	printOn {
		arg stream;
		stream << "BloodGlucose( " << values << ", " << rawPattern <<" )";
	}

}
