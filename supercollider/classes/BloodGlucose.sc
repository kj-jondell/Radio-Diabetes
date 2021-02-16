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

	createPatterns {
		arg repeats = 4;
		rawPattern = Pseq.new(values, repeats);
		differentiatedPattern = Pseq.new(this.prGetDifferentiated(values, order: 3, scale: 10), repeats);
	}

	printOn {
		arg stream;
		stream << "BloodGlucose( " << values << ", " << rawPattern <<" )";
	}

}
