/obj/hud/examine
	name = "examine effect"

	icon = 'icons/hud/hud.dmi'
	icon_state = "none"

	layer = LAYER_HUD
	plane = PLANE_HUD_MOUSE
	mouse_opacity = 0

	screen_loc = "CENTER,CENTER"

	alpha = 0

	user_colors = FALSE

	maptext = "<center>Nothing</center>"
	maptext_width = TILE_SIZE*5
	maptext_height = TILE_SIZE*2

/obj/hud/examine/New(var/desired_loc)

	if(ismob(desired_loc))
		screen_loc = "CENTER-2,TOP - 2"
		loc = desired_loc
		var/mob/ME = desired_loc
		if(ME.client)
			ME.client.screen += src

	..()