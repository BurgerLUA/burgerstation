var/global/list/all_loadouts = list()

SUBSYSTEM_DEF(loadouts)
	name = "NPC Loadout Subsystem"
	desc = "Store all the NPC loadouts."
	priority = SS_ORDER_PRELOAD

/subsystem/loadouts/Initialize()
	for(var/v in subtypesof(/loadout/))
		var/loadout/O = new v
		all_loadouts[O.type] = O
	log_subsystem(name,"Initialized [length(all_loadouts)] outfits.")

	return ..()