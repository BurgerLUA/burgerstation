/obj/hud/flash/
	name = "flash"

	icon = 'icons/hud/screen.dmi'
	icon_state = ""

	layer = 0
	plane = PLANE_HUD

	mouse_over_pointer = MOUSE_INACTIVE_POINTER

	mouse_opacity = 0

	user_colors = FALSE

	var/duration = 0

/obj/hud/flash/New(var/desired_loc)
	screen_loc = "LEFT,BOTTOM"
	. = ..()

/obj/hud/flash/Destroy()

	. = ..()

	if(owner)
		owner.client?.screen -= src
		owner = null