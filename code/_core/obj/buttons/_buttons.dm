/obj/button/
	name = "button"
	desc = "This button does something, I think."

	icon = 'icons/hud/inventory.dmi'
	icon_state = "slot"

	var/mob/owner //The mob that owns this button

	var/is_static = TRUE //Is the button anchored?

	layer = LAYER_HUD
	plane = PLANE_HUD

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	//var/click_sound = 'sounds/ui/beep-metallic.ogg'

/obj/button/proc/update_owner(var/mob/desired_owner)

	if(owner == desired_owner)
		return FALSE

	if(owner)
		owner.remove_button(src)

	owner = desired_owner
	owner.add_button(src)

	update_icon()

	return TRUE


/obj/button/clicked_by_object(var/mob/caller,object,location,control,params)

	/*
	if(caller && caller.client)
		caller.client << click_sound
	*/


	return TRUE