/obj/item/proc/prune_inventory()

	var/list/obj/hud/inventory/dynamic/bad_inventories = list()
	var/good_inventory_count = 0

	for(var/obj/hud/inventory/dynamic/I in inventories)

		if(!length(I.held_objects) && !length(I.worn_objects))
			bad_inventories += I
		else
			good_inventory_count += 1


	var/delete_until = good_inventory_count < 8 ? good_inventory_count : ceiling(good_inventory_count,8)

	for(var/obj/hud/inventory/dynamic/I in bad_inventories)
		if(I.slot_num > delete_until)
			inventories -= I
			qdel(I)

	return TRUE