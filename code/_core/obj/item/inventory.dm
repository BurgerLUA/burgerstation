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


/obj/item/proc/update_inventory() //When this object's inventory was updated.

	if(is_inventory(loc) && finalized)
		var/obj/hud/inventory/I = loc
		if(is_advanced(I.owner))
			var/mob/living/advanced/A = I.owner
			A.update_speed()

	return TRUE

/obj/item/Generate()
	fill_inventory()
	if(length(inventories))
		for(var/obj/item/I in src.contents)
			if(I.finalized)
				continue
			pre_fill_inventory(I)
			INITIALIZE(I)
			GENERATE(I)
			FINALIZE(I)
			post_fill_inventory(I)
			add_to_inventory(null,I,enable_messages=FALSE,bypass=TRUE,silent=TRUE)
	. = ..()

/obj/item/proc/fill_inventory()
	return TRUE


/obj/item/proc/pre_fill_inventory(var/obj/item/item_added)
	return TRUE

/obj/item/proc/post_fill_inventory(var/obj/item/item_added)
	return TRUE