/obj/item/proc/prune_inventory()

	var/list/obj/hud/inventory/dynamic/bad_inventories = list()
	var/good_inventory_count = 0

	for(var/k in inventories)
		var/obj/hud/inventory/dynamic/I = k
		if(!length(I.contents))
			bad_inventories += I
		else
			good_inventory_count += 1

	var/delete_until = good_inventory_count < max_inventory_x ? good_inventory_count : CEILING(good_inventory_count,8)

	for(var/k in bad_inventories)
		var/obj/hud/inventory/dynamic/I = k
		if(I.slot_num > delete_until)
			inventories -= I
			qdel(I)

	return TRUE


/obj/item/proc/update_inventory() //When this object's inventory (contents) was updated.
	return TRUE

/obj/item/proc/fill_inventory()
	return TRUE

/obj/item/proc/pre_fill_inventory(var/obj/item/item_added)
	return TRUE

/obj/item/proc/post_fill_inventory(var/obj/item/item_added)
	return TRUE