/atom/proc/on_mouse_up(mob/caller as mob, atom/object,location,control,params)
	return FALSE

/atom/proc/mouse_wheel_on_object(caller,delta_x,delta_y,location,control,params)
	return FALSE

/atom/proc/click_on_object(mob/caller as mob,atom/object,location,control,params) //The src is used on the object. This is called first.
	return FALSE

/atom/proc/click_on_object_alt(mob/caller as mob,atom/object,location,control,params) //Basically a special attack. For wielded objects.
	return FALSE

/atom/proc/clicked_on_by_object(mob/caller,atom/object,location,control,params)
	return FALSE

/atom/proc/drop_on_object(mob/caller,atom/object,location,control,params)
	return FALSE

/atom/proc/dropped_on_by_object(mob/caller,atom/object,location,control,params)
	return FALSE

/atom/get_examine_list(mob/examiner)
	var/object_icon = ICON_TO_HTML(icon,icon_state,32,32)
	return list(div("examine_title","[object_icon][src.name]"),div("examine_description","\"[src.desc]\""),div("examine_description_long",src.desc_extended))

/atom/proc/can_caller_interact_with(mob/caller,enable_message = TRUE,delay_checks=TRUE,distance_checks=TRUE,turf_checks=TRUE)

	if(src.qdeleting)
		return FALSE

	if(!caller || caller.qdeleting)
		return FALSE

	if(delay_checks && caller.client && caller.client.interact_next > world.time)
		return FALSE

	if(!ismob(caller))
		CRASH("Tried passing a non-mob ([caller.get_debug_name()]) as a caller when interacting with [src.get_debug_name()]!")

	. = FALSE //TODO: Fix this convoluted bullshit when I am not sleep deprived.

	if(is_living(caller))
		var/mob/living/L = caller
		if(L.dead && src.interaction_flags & FLAG_INTERACTION_DEAD)
			. = TRUE
		if(!L.dead && src.interaction_flags & FLAG_INTERACTION_LIVING)
			. = TRUE
		if(L.horizontal && src.interaction_flags & FLAG_INTERACTION_NO_HORIZONTAL)
			if(enable_message) caller.to_chat(span("warning","You need to be standing in order to interact with \the [src.name]!"))
			return FALSE
	else if(src.interaction_flags & FLAG_INTERACTION_DEAD)
		. = TRUE
	else
		if(enable_message) caller.to_chat(span("warning","The dead cannot interact with \the [src.name]!"))
		return FALSE

	if(turf_checks && !(src.interaction_flags & FLAG_INTERACTION_NO_TURF_CHECKING) && src.plane < PLANE_HUD && src.z && !caller.loc?.z)
		return FALSE

	if(distance_checks && !(src.interaction_flags & FLAG_INTERACTION_NO_DISTANCE) && get_dist(caller,src) > interact_distance)
		return FALSE

/atom/proc/click_self(mob/caller,location,control,params)
	return FALSE

/atom/proc/set_color(desired_color,desired_substype)
	color = desired_color
	return TRUE
