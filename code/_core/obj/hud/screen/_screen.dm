/obj/hud/screen/
	name = "screen"
	desc = "This does something, I think."

	icon = 'icons/hud/discovery.dmi'
	icon_state = "blank"

	layer = 0
	plane = PLANE_HUD

	mouse_over_pointer = MOUSE_INACTIVE_POINTER

	screen_loc = "CENTER-4.5,CENTER-4.5"

	mouse_opacity = 0

	var/time = 0
	var/is_fading = FALSE
	var/fade_out = FALSE
	var/client

	user_colors = FALSE