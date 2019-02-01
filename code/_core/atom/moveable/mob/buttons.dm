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