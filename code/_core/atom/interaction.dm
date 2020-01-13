/atom/proc/on_mouse_up(var/mob/caller as mob, var/atom/object,location,control,params)

	if(!object || !caller)
		return FALSE

	var/atom/defer_self = src.defer_click_on_object()
	var/atom/defer_object = object.defer_click_on_object()

	if(!defer_self || !defer_object)
		return FALSE

	if(src != defer_self && defer_self.on_mouse_up(caller,defer_object,location,control,params))
		return TRUE

	return FALSE

/atom/proc/on_mouse_wheel(caller,delta_x,delta_y,location,control,params)

	if(!caller)
		return FALSE

	var/atom/defer_self = src.defer_click_on_object()

	if(!defer_self)
		return FALSE

	if(src != defer_self && defer_self.on_mouse_wheel(caller,delta_x,delta_y,location,control,params))
		return TRUE

	return FALSE

/atom/proc/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object. This is called first.

	if(!object || !caller)
		return FALSE

	var/atom/defer_self = src.defer_click_on_object()
	var/atom/defer_object = object.defer_click_on_object()

	if(!defer_self || !defer_object)
		return FALSE

	if(src != defer_self && defer_self.click_on_object(caller,defer_object,location,control,params))
		return TRUE

	if(object.clicked_on_by_object(caller,src,location,control,params))
		return TRUE

	defer_self.attack(caller,defer_object,params)

	return TRUE

/atom/proc/clicked_on_by_object(var/atom/caller,var/atom/object,location,control,params)

	if(!object || !caller)
		return FALSE

	var/atom/defer_self = src.defer_click_on_object()
	var/atom/defer_object = object.defer_click_on_object()

	if(!defer_self || !defer_object)
		return FALSE

	if(src != defer_self && defer_self.clicked_on_by_object(caller,defer_object))
		return TRUE

	return FALSE

/atom/proc/drop_on_object(var/atom/caller,var/atom/object)

	if(!object)
		return FALSE

	var/atom/defer_self = src.defer_click_on_object()
	var/atom/defer_object = object.defer_click_on_object()

	if(src != defer_self && defer_self.drop_on_object(caller,defer_object))
		return TRUE

	if(src != defer_self && object && object.dropped_on_by_object(caller,defer_self))
		return TRUE

	if(object && object.dropped_on_by_object(caller,src))
		return TRUE

	/* ADDING THIS CAUSES ISSUES.
	if(click_on_object(caller,object))
		return TRUE
	*/

	return FALSE

/atom/proc/dropped_on_by_object(var/atom/caller,var/atom/object)

	if(!object)
		return FALSE

	var/atom/defer_self = src.defer_click_on_object()
	var/atom/defer_object = object.defer_click_on_object()

	if(src != defer_self && defer_self.dropped_on_by_object(caller,defer_object))
		return TRUE

	return FALSE

/atom/proc/get_examine_text(var/mob/examiner)
	return "[div("examine_title","[src.name]")][div("examine_description","\"[src.desc]\"")][div("examine_description_long","[src.desc_extended]")]"

/atom/proc/can_caller_interact_with(var/mob/caller,var/enable_message = TRUE)

	if(get_dist(src,caller) > interact_distance)
		if(enable_message)
			caller.to_chat(span("notice","You're too far away to interact with \the [src.name]!"))
		return FALSE

	return TRUE

/atom/proc/click_self(caller,location,control,params)
	return FALSE

/atom/proc/set_color(var/desired_color,var/desired_substype)
	color = desired_color
	return TRUE