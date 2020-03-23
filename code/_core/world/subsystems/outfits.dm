var/global/list/all_loadouts = list()

SUBSYSTEM_DEF(loadouts)
	name = "NPC Loadout Subsystem"
	desc = "Store all the NPC loadouts."
	priority = SS_ORDER_PRELOAD

/subsystem/loadouts/Initialize()
	for(var/v in subtypesof(/loadout/))
		var/loadout/O = new v
		if(O.id)
			all_loadouts[O.id] = O
		else
			qdel(O)

	LOG_SERVER("Initialized [length(all_loadouts)] outfits.")