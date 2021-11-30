/mob/living/advanced/proc/add_inventory(var/obj/hud/inventory/I)

	inventory += I
	if(I.id) inventories_by_id[I.id] = I

	if(client)
		client.screen += I
		client.known_inventory += I

	I.update_sprite()

	return TRUE

/mob/living/advanced/proc/remove_inventory(var/obj/hud/inventory/I)

	inventory -= I
	if(I.id) inventories_by_id -= I.id

	if(client)
		client.screen -= I
		client.known_inventory -= I

/mob/living/advanced/proc/remove_all_inventory()

	for(var/k in inventory)
		var/obj/hud/inventory/I = k
		remove_inventory(I)

	return TRUE


/mob/living/advanced/proc/restore_inventory()

	if(!client)
		return FALSE

	for(var/k in inventory)
		var/obj/hud/inventory/I = k
		client.screen += I

	return TRUE


/mob/living/advanced/proc/open_inventory(var/obj/hud/inventory/I)
	active_inventory = I
	return TRUE


/mob/living/advanced/proc/drop_hands(var/turf/T)
	. = list()
	if(inventories_by_id[BODY_HAND_LEFT_HELD])
		. += inventories_by_id[BODY_HAND_LEFT_HELD].drop_objects(T)
	if(inventories_by_id[BODY_HAND_RIGHT_HELD])
		. += inventories_by_id[BODY_HAND_RIGHT_HELD].drop_objects(T)

/mob/living/advanced/proc/strip_and_delete_items()

	for(var/k in worn_objects)
		var/obj/item/I = k
		qdel(I)

	for(var/k in held_objects)
		var/obj/item/I = k
		qdel(I)