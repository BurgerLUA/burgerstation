SUBSYSTEM_DEF(status)
	name = "Status Effect Subsystem"
	desc = "Controls the status effects of mobs."
	priority = SS_ORDER_PRELOAD

	var/list/all_status_effects = list()

/subsystem/status/Initialize()

	for(var/k in subtypesof(/status_effect/))
		var/status_effect/S = k
		var/id = initial(S.id)
		if(id)
			S = new k
			all_status_effects[id] = S

	return ..()