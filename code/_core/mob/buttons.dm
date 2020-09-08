/mob/proc/add_button(var/obj/hud/button/B) //This should never actually be used to add buttons. Call update_owner(M) instead on the button.
	buttons += B
	if(client)
		client.screen += B
	sync_buttons()

/mob/proc/remove_button(var/obj/hud/button/B) //This should never actually be used to remove buttons. Call update_owner(null) instead on the button.
	buttons -= B
	if(client)
		client.screen -= B
	sync_buttons()

/mob/proc/restore_buttons()

	if(!client)
		return

	for(var/k in buttons)
		var/obj/hud/button/B = k
		client.screen += B

	sync_buttons()

/mob/proc/sync_buttons()
	if(client)
		client.known_buttons = buttons.Copy()

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
	for(var/k in buttons)
		var/obj/hud/button/B = k
		if(B.flags & show_flags_whitelist && !(B.flags & show_flags_blacklist))
			B.show(show,speed)

//HUD
/mob/proc/show_hud(var/show,var/show_flags_whitelist=FLAGS_HUD_ALL,var/show_flags_blacklist=FLAGS_HUD_NONE,var/speed=1)
	show_buttons(show,show_flags_whitelist,show_flags_blacklist,speed)
	show_health(show,show_flags_whitelist,show_flags_blacklist,speed)

/mob/proc/display_turf_contents(var/turf/T)

	for(var/obj/hud/button/floor_object/B in buttons) //Clear existing.
		B.update_owner(null)

	var/list/valid_contents = list()
	for(var/k in T.contents)
		var/atom/movable/M = k
		if(M.invisibility > src.see_invisible)
			continue
		if(M.mouse_opacity <= 0)
			continue
		valid_contents += k

	var/i=0
	var/content_length = length(valid_contents)
	for(var/k in valid_contents)
		var/atom/movable/M = k
		var/obj/hud/button/floor_object/B = new(src)
		var/x_pos = sin( (i/content_length)*360 ) * content_length*0.3
		var/y_pos = cos( (i/content_length)*360 ) * content_length*0.3
		world.log << "X: [x_pos], Y: [y_pos]."
		B.screen_loc = "CENTER+[x_pos],CENTER+[y_pos]"
		B.associated_object = M
		B.associated_loc = T
		B.update_owner(src)
		i++

	return TRUE