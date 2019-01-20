//All mobs should have access to buttons.

/mob/living/advanced/proc/add_species_buttons()
	for(var/v in mob_species.spawning_buttons)
		var/obj/button/B = new v
		B.update_owner(src)

/mob/proc/add_button(var/obj/button/B)
	buttons += B
	if(client)
		client.screen += B
	B.update_owner(src)
	update_buttons()

/mob/proc/remove_button(var/obj/button/B)
	buttons -= B
	if(client)
		client.screen -= B
	B.update_owner(null)
	update_buttons()

/mob/proc/restore_buttons()
	if(!client)
		return

	for(var/obj/button/B in buttons)
		client.screen += B

	update_buttons()

/mob/proc/update_buttons()
	if(client)
		client.known_buttons = buttons