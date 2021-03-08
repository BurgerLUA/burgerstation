SUBSYSTEM_DEF(footstep)
	name = "Footstep Subsystem"
	desc = "Store all the footstep effects."
	priority = SS_ORDER_PRELOAD
	var/list/footstep/all_footsteps = list()

/subsystem/footstep/Initialize()

	for(var/k in subtypesof(/footstep/))
		var/footstep/F = k
		F = new k
		all_footsteps[F.type] = F

	log_subsystem(name,"Initialized [length(all_footsteps)] footstep types.")

	return ..()