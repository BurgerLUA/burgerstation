/mob/proc/add_inventory(var/obj/inventory/I)
	inventory += I
	if(client)
		client.screen += I
	update_inventory()

/mob/proc/remove_inventory(var/obj/inventory/I)
	inventory -= I
	if(client)
		client.screen -= I
	update_inventory()

/mob/proc/update_inventory()
	if(client)
		client.known_inventory = inventory