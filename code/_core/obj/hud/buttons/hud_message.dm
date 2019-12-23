var/global/list/obj/hud/button/message/all_hud_messages = list()


/obj/hud/button/message/
	name = "hud message"
	desc = ""
	icon_state = "invisible"
	screen_loc = "CENTER,CENTER+2"

	flags = FLAGS_HUD_MOB | FLAGS_HUD_SPECIAL

	maptext_x = -(TILE_SIZE*VIEW_RANGE) + 16
	maptext_width = TILE_SIZE*VIEW_RANGE*2
	maptext_height = TILE_SIZE*VIEW_RANGE
	maptext = "ERROR"

	mouse_opacity = 0

/obj/hud/button/message/New(var/desired_loc)
	alpha = 0
	all_hud_messages += src
	return ..()

/obj/hud/button/message/Destroy()
	all_hud_messages -= src
	return ..()

/obj/hud/button/message/proc/set_text(var/desired_text)

	alpha = 0
	maptext = "<center><font size='3'>[desired_text]</font></center>"

	animate(src,alpha=255,time=40)
	spawn(100) animate(src,alpha=0,time=40)

	return TRUE

