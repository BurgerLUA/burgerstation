/mob/living/advanced/proc/add_inventory(var/obj/hud/inventory/I)

	if(I.id == BODY_HAND_LEFT_HELD)
		left_hand = I

	if(I.id == BODY_HAND_RIGHT_HELD)
		right_hand = I

	if(I.id == BODY_TORSO_OB)
		holster = I

	if(I.id == BODY_FACE)
		face = I

	inventory += I

	if(client)
		client.screen += I
		client.known_inventory += I

	I.update_sprite()

	return TRUE

/mob/living/advanced/proc/remove_inventory(var/obj/hud/inventory/I)

	if(I.id == BODY_HAND_LEFT_HELD)
		left_hand = null

	if(I.id == BODY_HAND_RIGHT_HELD)
		right_hand = null

	if(I.id == BODY_TORSO_OB)
		holster = null

	if(I.id == BODY_FACE)
		face = null

	inventory -= I

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
	if(left_hand) . += left_hand.drop_objects(T)
	if(right_hand) . += right_hand.drop_objects(T)

/mob/living/advanced/proc/strip_and_delete_items()

	for(var/k in worn_objects)
		var/obj/item/I = k
		qdel(I)

	for(var/k in held_objects)
		var/obj/item/I = k
		qdel(I)