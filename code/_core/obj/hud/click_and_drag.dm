/obj/hud/click_and_drag
	name = "click and drag effect"

	icon = 'icons/hud/new.dmi'
	icon_state = "slot"

	layer = LAYER_HUD
	plane = PLANE_HUD
	mouse_opacity = 0

	screen_loc = "CENTER,CENTER"

	alpha = 0

	var/atom/stored_object

/obj/hud/click_and_drag/destroy()
	stored_object = null
	return ..()

/obj/hud/click_and_drag/New(var/desired_loc)

	if(is_mob(desired_loc))
		screen_loc = "CENTER,CENTER"
		loc = desired_loc
		var/mob/ME = desired_loc
		if(ME.client)
			ME.client.screen += src

	..()