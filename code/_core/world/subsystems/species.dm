var/global/list/chargen_species = list()

/subsystem/chargen/
	name = "Chargen Subsystem"
	desc = "Basically allows the chargen system not to be dumb."
	priority = SS_ORDER_PRELOAD

/subsystem/chargen/Initialize()
	for(var/v in subtypesof(/species/))
		var/species/S = new v
		chargen_species[S.id] = S

	LOG_SERVER("Initialized [length(chargen_species)] species.")
