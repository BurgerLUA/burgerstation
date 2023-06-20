var/global/list/obj/hud/button/message/all_hud_messages = list()

/proc/set_message(var/desired_text,var/instant = FALSE)

	for(var/k in all_hud_messages)
		var/obj/hud/button/message/M = k
		if(desired_text && M.owner)
			var/area/A = get_area(M.owner)
			if(!A || (A.flags_area & FLAG_AREA_NO_ROUND_INFORMATION))
				M.set_text(null,instant)
				continue
		M.set_text(desired_text,instant)

	return TRUE

/obj/hud/button/message/
	name = "hud message"
	desc = ""
	icon_state = "invisible"
	screen_loc = "CENTER,TOP"

	flags_hud = FLAG_HUD_MOB | FLAG_HUD_SPECIAL

	maptext_x = -(TILE_SIZE*VIEW_RANGE) + 16
	maptext_width = TILE_SIZE*VIEW_RANGE*2
	maptext_height = TILE_SIZE*VIEW_RANGE
	maptext = "ERROR"

	mouse_opacity = 0

	has_quick_function = FALSE

	var/current_text

/obj/hud/button/message/New(var/desired_loc)
	alpha = 0
	all_hud_messages += src
	return ..()

/obj/hud/button/message/PreDestroy()
	all_hud_messages -= src
	return ..()

/obj/hud/button/message/proc/set_text(var/desired_text,var/instant = FALSE)

	if(!desired_text)
		if(instant)
			alpha = 0
		else
			animate(src,alpha=0,time=40)
	else if(current_text != desired_text)
		if(instant)
			alpha = 255
			maptext = "<center><font size='2'>[desired_text]</font></center>"
		else
			alpha = 0
			maptext = "<center><font size='2'>[desired_text]</font></center>"
			animate(src,alpha=255,time=40)
		current_text = desired_text

	return TRUE

