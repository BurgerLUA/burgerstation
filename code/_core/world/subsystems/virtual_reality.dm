SUBSYSTEM_DEF(virtual_reality)
	name = "Virtual Reality Subsystem"
	desc = "Stores all the known virtual reality programs in a list."
	priority = SS_ORDER_PRELOAD

	var/list/virtual_reality_programs = list()

	var/virtual_reality/current_virtual_reality

/subsystem/virtual_reality/Initialize()
	for(var/A in subtypesof(/virtual_reality/))
		var/virtual_reality/VR = A
		if(initial(VR.name))
			virtual_reality_programs += VR

	log_subsystem(name,"Fetched [length(virtual_reality_programs)] virtual reality programs.")

	return ..()


/subsystem/virtual_reality/proc/set_virtual_reality(var/virtual_reality/desired_virtual_reality)
	if(current_virtual_reality)
		qdel(current_virtual_reality)
	current_virtual_reality = new desired_virtual_reality
	log_debug("Currenct virtual reality program set to [current_virtual_reality].")