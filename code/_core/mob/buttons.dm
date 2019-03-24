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

/mob/proc/toggle_health(var/important_too = FALSE,var/speed = 1)
	draw_health = !draw_health
	for(var/k in health_elements)
		var/obj/button/health/H = health_elements[k]
		if(draw_health)
			animate(H,alpha=255,time=SECONDS_TO_DECISECONDS(speed))
		else
			animate(H,alpha=0,time=SECONDS_TO_DECISECONDS(speed))

/mob/proc/toggle_buttons(var/important_too = FALSE,var/speed = 1)
	draw_buttons = !draw_buttons
	for(var/obj/button/B in buttons)
		if(draw_buttons)
			animate(B,alpha=255,time=SECONDS_TO_DECISECONDS(speed))
		else
			animate(B,alpha=0,time=SECONDS_TO_DECISECONDS(speed))

/mob/proc/show_hud(var/show,var/speed=1)
	if(!show)
		if(draw_buttons)
			toggle_buttons(TRUE,speed)
		if(draw_health)
			toggle_health(TRUE,speed)
	else
		if(!draw_buttons)
			toggle_buttons(TRUE,speed)
		if(!draw_health)
			toggle_health(TRUE,speed)

/mob/living/advanced/show_hud(var/show,var/speed=1)
	..()
	if(!show)
		if(draw_inventory)
			toggle_inventory(TRUE,speed)
	else
		if(!draw_inventory)
			toggle_inventory(TRUE,speed)