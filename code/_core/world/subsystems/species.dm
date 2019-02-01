var/global/list/chargen_species = list()

/subsystem/chargen/
	name = "Chargen Subsystem"
	desc = "Basically allows the chargen system not to be dumb."
	priority = SS_ORDER_CHARGEN

/subsystem/chargen/on_life()

	for(var/v in subtypesof(/species/))
		var/species/S = new v
		chargen_species[S.id] = S

	return FALSE