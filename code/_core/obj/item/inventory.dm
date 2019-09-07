/obj/item/proc/prune_inventory()

	for(var/obj/hud/inventory/I in inventories)
		if(!length(I.held_objects) && !length(I.worn_objects))
			inventories -= I
			qdel(I)

	return TRUE