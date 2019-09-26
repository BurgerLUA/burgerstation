/obj/hud/button/
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

	var/essential = FALSE

	var/flags = FLAGS_HUD_NONE

/obj/hud/button/destroy()
	owner = null
	return ..()

/obj/hud/button/proc/show(var/should_show=TRUE,var/draw_speed=2)
	if(should_show)
		animate(src,alpha=255,time=SECONDS_TO_DECISECONDS(draw_speed))
		src.mouse_opacity = 2
	else
		animate(src,alpha=0,time=SECONDS_TO_DECISECONDS(draw_speed))
		src.mouse_opacity = 0

/obj/hud/button/proc/update_owner(var/mob/desired_owner)

	if(owner == desired_owner)
		return FALSE

	if(owner && desired_owner != null)
		owner.remove_button(src)

	if(desired_owner)
		owner = desired_owner
		owner.add_button(src)
		update_icon()
	else
		qdel(src)

	return TRUE


/obj/hud/button/clicked_by_object(var/mob/caller,object,location,control,params)
	return TRUE