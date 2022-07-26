/obj/hud/button/tooltip
	name = "tooltip"
	mouse_opacity = 0
	alpha = 0
	screen_loc = "TOP,LEFT"

	icon = 'icons/hud/tooltip.dmi'
	icon_state = "tooltip"

	maptext_x = 2
	maptext_y = 3

	maptext_width = TILE_SIZE*4 - 4
	maptext_height = TILE_SIZE*2 - 6

	flags_hud = FLAG_HUD_MOB

	layer = 1000

/obj/hud/button/tooltip/proc/set_text(var/desired_text,var/desired_screen_loc)

	if(!desired_text || !desired_screen_loc)
		alpha = 0
		return FALSE

	alpha = 255
	screen_loc = desired_screen_loc
	maptext = "<font valign='top'>[desired_text]</font>"

	return TRUE

