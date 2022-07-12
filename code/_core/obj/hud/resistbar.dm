/obj/hud/resistbar
	name = "resist bar"
	icon = 'icons/hud/escape.dmi'
	icon_state = "escape"

	layer = LAYER_HUD
	plane = PLANE_HUD

	screen_loc = "CENTER,CENTER-1"

	var/obj/stored_line

	mouse_opacity = 0
	alpha = 0

/obj/hud/resistbar/New(var/desired_loc)
	. = ..()

	stored_line = new
	stored_line.appearance_flags = src.appearance_flags
	stored_line.icon_state = "escape_line"
	src.add_overlay(stored_line)