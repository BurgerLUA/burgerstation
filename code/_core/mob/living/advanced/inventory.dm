/mob/living/advanced/proc/add_inventory(var/obj/hud/inventory/I)

	I.update_sprite()

	if(I.id == BODY_HAND_LEFT)
		left_hand = I

	if(I.id == BODY_HAND_RIGHT)
		right_hand = I

	if(I.id == BODY_TORSO_OB)
		holster = I

	inventory += I

	if(client)
		client.screen += I
		client.known_inventory += I

	return TRUE

/mob/living/advanced/proc/remove_inventory(var/obj/hud/inventory/I)

	if(I.id == BODY_HAND_LEFT)
		left_hand = null

	if(I.id == BODY_HAND_RIGHT)
		right_hand = null

	if(I.id == BODY_TORSO_OB)
		holster = null

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
	return .
