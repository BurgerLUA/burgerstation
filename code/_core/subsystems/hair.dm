var/global/list/hair_types = list()

/datum/subsystem/hair/
	name = "Hair Subsystem"
	desc = "Yes, there is a fucking subsystem dedicated to hair."
	priority = SS_ORDER_HAIR

/datum/subsystem/hair/on_life()

	for(var/v in subtypesof(/hair/))
		var/hair/H = new v
		hair_types[H.id] = H

	return FALSE