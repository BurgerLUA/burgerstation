
/mob/living/advanced/Move(var/atom/NewLoc,Dir=0x0,desired_step_x=0,desired_step_y=0,var/silent=FALSE,var/force=FALSE)

	var/OldLoc = loc

	if(right_hand && right_hand.grabbed_object)
		right_hand.check_grab()

	if(left_hand && left_hand.grabbed_object)
		left_hand.check_grab()

	. = ..()

	if(.)

		//Right hand
		if(right_hand && right_hand.grabbed_object)
			var/distance = get_dist(src,right_hand.grabbed_object)
			if(distance > 1)
				right_hand.grabbed_object.glide_size = glide_size
				right_hand.grabbed_object.Move(OldLoc,silent=TRUE)

		//Left hand
		if(left_hand && left_hand.grabbed_object)
			var/distance = get_dist(src,left_hand.grabbed_object)
			if(distance > 1)
				left_hand.grabbed_object.glide_size = glide_size
				left_hand.grabbed_object.Move(OldLoc,silent=TRUE)


		/*
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
		*/

	return .


/obj/hud/inventory/proc/grab_object(var/mob/caller as mob,var/atom/movable/object,location,control,params)

	if(!ismovable(object) || !object.can_be_grabbed(caller))
		return FALSE

	if(!isturf(caller.loc))
		return FALSE

	if(length(held_objects) || grabbed_object)
		caller.to_chat(span("notice","You need an empty hand to grab this!"))
		return FALSE

	if(grabbed_object == object)
		caller.to_chat(span("notice","You cannot grab yourself!"))
		return FALSE

	if(grabbed_object)
		release_object() //Release the old object, if any.

	if(object.grabbing_hand)
		object.grabbing_hand.release_object()

	caller.set_dir(get_dir(caller,object))

	grabbed_object = object
	caller.to_chat(span("notice","You grab \the [object.name]."))
	animate(grabbed_object,pixel_x = initial(grabbed_object.pixel_x), pixel_y = initial(grabbed_object.pixel_y), time = SECONDS_TO_DECISECONDS(1))
	grabbed_object.grabbing_hand = src

	overlays.Cut()
	update_overlays()

	return TRUE

/obj/hud/inventory/proc/check_grab()

	if(!grabbed_object)
		return FALSE

	if(!grabbed_object.can_be_grabbed(owner) || !can_grab(owner,grabbed_object))
		release_object(owner)
		return FALSE

	return TRUE

/obj/hud/inventory/proc/release_object(var/mob/caller as mob)
	if(caller) caller.to_chat(span("notice","You release \the [grabbed_object.name]."))
	if(is_living(grabbed_object))
		var/mob/living/L = grabbed_object
		L.next_resist = 0
		L.resist_counter = 0
	grabbed_object.grabbing_hand = null
	grabbed_object = null
	overlays.Cut()
	update_overlays()
	return TRUE

/obj/hud/inventory/proc/can_grab(var/mob/caller,var/atom/movable/object)

	if(!object || !caller)
		return FALSE

	if(get_dist(caller,object) >= 2)
		return FALSE

	if(!isturf(caller.loc))
		return FALSE

	return TRUE