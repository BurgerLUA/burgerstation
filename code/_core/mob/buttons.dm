/mob/proc/add_button(var/obj/button/B)
	B = new B
	buttons += B
	if(client)
		client.screen += B
	update_buttons()

/mob/proc/remove_button(var/obj/button/B)
	buttons -= B
	if(client)
		client.screen -= B
	update_buttons()

/mob/proc/update_buttons()
	if(client)
		client.known_buttons = buttons