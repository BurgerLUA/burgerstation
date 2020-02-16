
/mob/living/advanced/Move(var/atom/NewLoc,Dir=0,desired_step_x=0,desired_step_y=0,var/silent=FALSE)

	var/OldLoc = loc

	if(right_hand && right_hand.grabbed_object)
		var/distance = get_dist(src,right_hand.grabbed_object)
		if(distance > 1)
			right_hand.release_object(src)

	if(left_hand && left_hand.grabbed_object)
		var/distance = get_dist(src,left_hand.grabbed_object)
		if(distance > 1)
			left_hand.release_object(src)

	. = ..()

	if(.)

		if(right_hand && right_hand.grabbed_object)
			var/distance = get_dist(src,right_hand.grabbed_object)
			if(distance > 2)
				right_hand.release_object(src)

		if(left_hand && left_hand.grabbed_object)
			var/distance = get_dist(src,left_hand.grabbed_object)
			if(distance > 2)
				left_hand.release_object(src)

		spawn()
			if(left_hand && left_hand.grabbed_object)
				var/distance = get_dist(src,left_hand.grabbed_object)
				if(distance > 2)
					left_hand.release_object(src)
				else if(distance > 1)
					left_hand.grabbed_object.glide_size = glide_size
					if(!left_hand.grabbed_object.Move(OldLoc,Dir,silent=TRUE))
						left_hand.release_object(src)

			if(right_hand && right_hand.grabbed_object)
				var/distance = get_dist(src,right_hand.grabbed_object)
				if(distance > 2)
					right_hand.release_object(src)
				else if(distance > 1)
					right_hand.grabbed_object.glide_size = glide_size
					if(!right_hand.grabbed_object.Move(OldLoc,Dir,silent=TRUE))
						right_hand.release_object(src)

	return .


/obj/hud/inventory/proc/grab_object(var/mob/caller as mob,var/atom/movable/object,location,control,params)

	if(!is_movable(object) || !object.can_be_grabbed(caller))
		caller.to_chat(span("notice","You cannot grab this!"))
		return FALSE

	if(length(held_objects) || grabbed_object)
		caller.to_chat(span("notice","You need an empty hand to grab this!"))
		return FALSE

	if(object.grabbing_hand)
		object.grabbing_hand.release_object()

	caller.to_chat(span("notice","You grab \the [object.name]."))
	grabbed_object = object
	animate(grabbed_object,pixel_x = initial(grabbed_object.pixel_x), pixel_y = initial(grabbed_object.pixel_y), time = SECONDS_TO_DECISECONDS(1))
	grabbed_object.grabbing_hand = src
	update_overlays()

	return TRUE

/obj/hud/inventory/proc/release_object(var/mob/caller as mob)
	if(caller)
		caller.to_chat(span("notice","You release \the [grabbed_object.name]."))
	grabbed_object.grabbing_hand = null
	grabbed_object = null
	update_overlays()
	return TRUE