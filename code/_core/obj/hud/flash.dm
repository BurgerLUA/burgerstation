/obj/hud/flash/
	name = "flash"

	icon = 'icons/hud/screen.dmi'
	icon_state = ""

	plane = PLANE_HUD_DAMAGE
	layer = LAYER_FLASH

	mouse_over_pointer = MOUSE_INACTIVE_POINTER

	mouse_opacity = 0

	user_colors = FALSE

	var/duration = 0

/obj/hud/flash/New(var/desired_loc)
	screen_loc = "LEFT,BOTTOM:12"
	. = ..()

/obj/hud/flash/PreDestroy()

	if(owner) owner.client?.screen -= src

	. = ..()