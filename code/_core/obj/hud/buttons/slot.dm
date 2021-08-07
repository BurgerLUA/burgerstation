/obj/hud/button/slot
	name = "slot button"
	var/id = null
	desc = "Slot button for quick actions."
	desc_extended = "Press this button to activate that item on the tile you're pointing."
	icon_state = "square_trim"
	screen_loc = "LEFT+0.25,TOP-0.25"
	alpha = 0

	flags = FLAGS_HUD_MOB

	var/obj/stored_object

	plane = PLANE_HUD
	layer = 1

	mouse_over_pointer = MOUSE_ACTIVE_POINTER
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_zone = 1

	mouse_opacity = 2

	has_quick_function = FALSE

/obj/hud/button/slot/Destroy()
	stored_object = null
	return ..()

/obj/hud/button/slot/update_owner(var/mob/desired_owner)

	if(owner && !desired_owner && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.slot_buttons -= id

	. = ..()

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.slot_buttons[id] = src

/obj/hud/button/slot/proc/activate_button(var/mob/living/advanced/caller)

	if(!stored_object)
		return FALSE

	if(!caller.client)
		return FALSE

	if(stored_object.qdeleting)
		clear_object()
		return FALSE

	var/client/C = caller.client

	if(stored_object.quick(caller,C.last_object,C.last_location,C.last_params))
		animate(src,color="#00FF00",time=1,flags=ANIMATION_PARALLEL)
	else
		animate(src,color="#FF0000",time=1,flags=ANIMATION_PARALLEL)

	animate(color="#FFFFFF",time=5)

	return TRUE

/obj/hud/button/slot/proc/clear_object()
	if(stored_object)
		vis_contents -= stored_object
		stored_object = null
	alpha = 0
	invisibility = 101
	return TRUE

/obj/hud/button/slot/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	return TRUE

/obj/hud/button/slot/proc/store_object(var/atom/object,location,control,params)

	if(!object)
		return FALSE

	var/obj/O = object

	if(!istype(O) || !O.has_quick_function)
		return TRUE

	clear_object()

	stored_object = O
	vis_contents += stored_object

	alpha = 200
	invisibility = 0

	return TRUE

/obj/hud/button/slot/A
	id = "1"
	maptext = "1"
	screen_loc = "LEFT+0.25,TOP-0.25"

/obj/hud/button/slot/B
	id = "2"
	maptext = "2"
	screen_loc = "LEFT+1+0.25,TOP-0.25"

/obj/hud/button/slot/C
	id = "3"
	maptext = "3"
	screen_loc = "LEFT+2+0.25,TOP-0.25"

/obj/hud/button/slot/D
	id = "4"
	maptext = "4"
	screen_loc = "LEFT+3+0.25,TOP-0.25"

/obj/hud/button/slot/E
	id = "5"
	maptext = "5"
	screen_loc = "LEFT+4+0.25,TOP-0.25"

/obj/hud/button/slot/F
	id = "6"
	maptext = "6"
	screen_loc = "LEFT+5+0.25,TOP-0.25"

/obj/hud/button/slot/G
	id = "7"
	maptext = "7"
	screen_loc = "LEFT+6+0.25,TOP-0.25"

/obj/hud/button/slot/H
	id = "8"
	maptext = "8"
	screen_loc = "LEFT+7+0.25,TOP-0.25"

/obj/hud/button/slot/I
	id = "9"
	maptext = "9"
	screen_loc = "LEFT+8+0.25,TOP-0.25"

/obj/hud/button/slot/J
	id = "0"
	maptext = "0"
	screen_loc = "LEFT+9+0.25,TOP-0.25"