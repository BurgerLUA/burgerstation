var/global/list/all_outfits = list()

SUBSYSTEM_DEF(outfits)
	name = "Outfit Subsystem"
	desc = "Store all the outfits."
	priority = SS_ORDER_PRELOAD

/subsystem/outfits/Initialize()
	for(var/v in subtypesof(/outfit/))
		var/outfit/O = new v
		if(O.id)
			all_outfits[O.id] = O
		else
			qdel(O)

	LOG_SERVER("Initialized [length(all_outfits)] outfits.")