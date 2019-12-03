/mob/living/advanced/proc/add_inventory(var/obj/hud/inventory/I)

	I.update_icon()

	if(I.id == BODY_HAND_LEFT)
		left_hand = I

	if(I.id == BODY_HAND_RIGHT)
		right_hand = I

	inventory += I

	if(client)
		client.screen += I
		client.known_inventory += I

/mob/living/advanced/proc/remove_inventory(var/obj/hud/inventory/I)

	if(I.id == BODY_HAND_LEFT)
		left_hand = null

	if(I.id == BODY_HAND_RIGHT)
		right_hand = null

	inventory -= I

	if(client)
		client.screen -= I
		client.known_inventory -= I

/mob/living/advanced/proc/remove_all_inventory()

	for(var/obj/hud/inventory/I in inventory)
		remove_inventory(I)


/mob/living/advanced/proc/restore_inventory()
	if(!client)
		return

	for(var/obj/hud/inventory/I in inventory)
		client.screen += I


/mob/living/advanced/proc/open_inventory(var/obj/hud/inventory/I)
	active_inventory = I

