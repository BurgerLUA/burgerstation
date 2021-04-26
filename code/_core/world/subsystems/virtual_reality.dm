SUBSYSTEM_DEF(virtual_reality)
	name = "Virtual Reality Subsystem"
	desc = "Stores all the known virtual reality programs in a list."
	priority = SS_ORDER_PRELOAD

	tick_rate = SECONDS_TO_TICKS(1)

	cpu_usage_max = 100
	tick_usage_max = 100

	var/list/virtual_reality_programs = list()

	var/virtual_reality/current_virtual_reality

/subsystem/virtual_reality/Initialize()

	for(var/A in subtypesof(/virtual_reality/))
		var/virtual_reality/VR = A
		if(initial(VR.name))
			virtual_reality_programs += VR

	log_subsystem(name,"Fetched [length(virtual_reality_programs)] virtual reality programs.")

	. = ..()

/subsystem/virtual_reality/on_life()

	if(current_virtual_reality)
		current_virtual_reality.on_life()

	return TRUE


/subsystem/virtual_reality/proc/set_virtual_reality(var/virtual_reality/desired_virtual_reality)
	if(current_virtual_reality)
		qdel(current_virtual_reality)
	current_virtual_reality = new desired_virtual_reality
	INITIALIZE(current_virtual_reality)
	log_debug("Current virtual reality program set to [current_virtual_reality].")