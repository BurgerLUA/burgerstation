/atom/proc/on_mouse_up(var/mob/caller as mob, var/atom/object,location,control,params)
	return FALSE

/atom/proc/mouse_wheel_on_object(caller,delta_x,delta_y,location,control,params)
	return FALSE

/atom/proc/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object. This is called first.
	return FALSE

/atom/proc/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	return FALSE

/atom/proc/drop_on_object(var/mob/caller,var/atom/object,location,control,params)
	return FALSE

/atom/proc/dropped_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	return FALSE

/atom/get_examine_list(var/mob/examiner)
	var/object_icon = ICON_TO_HTML(icon,icon_state,32,32)
	return list(div("examine_title","[object_icon][src.name]"),div("examine_description","\"[src.desc]\""),div("examine_description_long",src.desc_extended))

/atom/proc/can_caller_interact_with(var/mob/caller,var/enable_message = TRUE,var/delay_checks=TRUE,var/distance_checks=TRUE)

	if(src.qdeleting)
		return FALSE

	if(!caller || caller.qdeleting)
		return FALSE

	if(delay_checks && caller.client && caller.client.interact_next > world.time)
		return FALSE

	if(!ismob(caller))
		CRASH_SAFE("Tried passing a non-mob ([caller.get_debug_name()]) as a caller when interacting with [src.get_debug_name()]!")
		return FALSE

	. = FALSE

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

	if(distance_checks && !(src.interaction_flags & FLAG_INTERACTION_NO_DISTANCE) && get_dist(src,caller) > interact_distance)
		//if(enable_message) caller.to_chat(span("warning","You're too far away to interact with \the [src.name]!")) THIS WAS ANNOYING
		return FALSE

	return .

/atom/proc/click_self(var/mob/caller as mob,location,control,params)
	return FALSE

/atom/proc/set_color(var/desired_color,var/desired_substype)
	color = desired_color
	return TRUE