var/global/list/all_outfits = list()

/subsystem/outfits/
	name = "Outfit Subsystem"
	desc = "Store all the outfits."
	priority = SS_ORDER_OUTFITS

/subsystem/outfits/Initialize()
	for(var/v in subtypesof(/outfit/))
		var/outfit/O = new v
		if(O.id)
			all_outfits[O.id] = O
		else
			qdel(O)