/obj/hud/click_and_drag
	name = "click and drag effect"

	icon = 'icons/hud/hud.dmi'
	icon_state = "slot"

	layer = LAYER_HUD
	plane = PLANE_HUD_OBJ
	mouse_opacity = 0

	screen_loc = "CENTER,CENTER"

	alpha = 0

	var/obj/item/stored_object
	var/obj/hud/inventory/stored_inventory

	user_colors = FALSE

	layer = 100

/obj/hud/click_and_drag/Destroy()
	stored_object = null
	stored_inventory = null
	. = ..()

/obj/hud/click_and_drag/New(var/desired_loc)

	if(ismob(desired_loc))
		screen_loc = "CENTER,CENTER"
		loc = desired_loc
		var/mob/ME = desired_loc
		if(ME.client)
			ME.client.screen += src

	..()