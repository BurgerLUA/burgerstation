/mob/proc/add_inventory(var/obj/inventory/I)

	if(I.id == BODY_HAND_LEFT)
		left_hand = I

	if(I.id == BODY_HAND_RIGHT)
		right_hand = I

	inventory += I
	if(client)
		client.screen += I
	update_inventory()

/mob/proc/remove_inventory(var/obj/inventory/I)

	if(I.id == BODY_HAND_LEFT)
		left_hand = null

	if(I.id == BODY_HAND_RIGHT)
		right_hand = null

	inventory -= I
	if(client)
		client.screen -= I
	update_inventory()

/mob/proc/restore_inventory()
	if(!client)
		return

	for(var/obj/inventory/I in inventory)
		client.screen += I

	update_inventory()

/mob/proc/update_inventory()
	if(client)
		client.known_inventory = inventory
