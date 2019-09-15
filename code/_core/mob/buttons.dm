/mob/proc/add_button(var/obj/hud/button/B)
	buttons += B
	if(client)
		client.screen += B
	B.update_owner(src)
	update_buttons()

/mob/proc/remove_button(var/obj/hud/button/B)
	buttons -= B
	if(client)
		client.screen -= B
	B.update_owner(null)
	update_buttons()

/mob/proc/restore_buttons()
	if(!client)
		return

	for(var/obj/hud/button/B in buttons)
		client.screen += B

	update_buttons()

/mob/proc/update_buttons()
	if(client)
		client.known_buttons = buttons

//Health
/mob/proc/toggle_health(var/show_flags_whitelist=FLAGS_HUD_ALL,var/show_flags_blacklist=FLAGS_HUD_NONE,var/speed = 1)
	draw_health = !draw_health
	show_health(draw_health,show_flags_whitelist,show_flags_blacklist,speed)

/mob/proc/show_health(var/show=TRUE,var/show_flags_whitelist,var/show_flags_blacklist,var/speed)
	for(var/k in health_elements)
		var/obj/hud/button/H = health_elements[k]
		if(H.flags & show_flags_whitelist && !(H.flags & show_flags_blacklist))
			H.show(show,speed)

//Buttons
/mob/proc/toggle_buttons(var/show_flags_whitelist=FLAGS_HUD_ALL,var/show_flags_blacklist=FLAGS_HUD_NONE,var/speed = 1)
	draw_buttons = !draw_buttons
	show_buttons(draw_buttons,show_flags_whitelist,show_flags_blacklist,speed)

/mob/proc/show_buttons(var/show=TRUE,var/show_flags_whitelist,var/show_flags_blacklist,var/speed)
	for(var/obj/hud/button/B in buttons)
		if(B.flags & show_flags_whitelist && !(B.flags & show_flags_blacklist))
			B.show(show,speed)

//HUD
/mob/proc/show_hud(var/show,var/show_flags_whitelist=FLAGS_HUD_ALL,var/show_flags_blacklist=FLAGS_HUD_NONE,var/speed=1)
	show_buttons(show,show_flags_whitelist,show_flags_blacklist,speed)
	show_health(show,show_flags_whitelist,show_flags_blacklist,speed)

