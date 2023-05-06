/atom/proc/Initialize()
	if(reagents)
		reagents = new reagents(src)
	if(health)
		health = new health(src)
	if(listener)
		all_listeners += src
	return TRUE

/atom/proc/PostInitialize()
	return TRUE

/atom/proc/Generate() //Generate the atom, giving it stuff if needed.
	return TRUE

/atom/proc/Finalize() //We're good to go.
	update_name(name) //Setup labels
	update_atom_light()
	if(health)
		health.Finalize()
	if(reagents && length(reagents.stored_reagents) > 0)
		reagents.update_container(force=TRUE)
		//Don't check recipes here. If you created an item that needs to process recipes after it was created, then you made shitcode.
	return TRUE

