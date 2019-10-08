var/global/list/all_species = list()

/subsystem/chargen/
	name = "Chargen Subsystem"
	desc = "Basically allows the chargen system not to be dumb."
	priority = SS_ORDER_PRELOAD

/subsystem/chargen/Initialize()
	for(var/k in subtypesof(/species/))
		var/species/S = k
		var/s_id = initial(S.id)
		if(s_id)
			S = new k
			all_species[s_id] = S

	LOG_SERVER("Initialized [length(all_species)] species.")
