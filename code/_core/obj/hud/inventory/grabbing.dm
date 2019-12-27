/* OLD MOVEMENT
/obj/hud/inventory/proc/do_drag(var/turf/T,var/movement_override = 0)
	var/distance = get_dist(owner,grabbed_object)
	if(grabbed_object && distance > 1)
		if(distance > 2 || !grabbed_object.do_step(T,movement_override))
			release_object()
			return FALSE

	return TRUE
*/


/mob/living/advanced/Move(NewLoc,Dir=0,step_x=0,step_y=0)

	. = ..()

	if(.)
		spawn()
			if(left_hand && left_hand.grabbed_object)
				var/turf/back_turf = get_step(src,turn(move_dir, 180))
				var/distance = get_dist(src,left_hand.grabbed_object) > 1
				if(distance > 2)
					left_hand.release_object(src)
				else if(distance > 1)
					left_hand.grabbed_object.glide_size = glide_size
					left_hand.grabbed_object.Move(back_turf,Dir)

			if(right_hand && right_hand.grabbed_object)
				var/turf/back_turf = get_step(src,turn(move_dir, 180))
				var/distance = get_dist(src,right_hand.grabbed_object)
				if(distance > 2)
					right_hand.release_object(src)
				else if(distance > 1)
					right_hand.grabbed_object.glide_size = glide_size
					right_hand.grabbed_object.Move(back_turf,Dir)

	return .


/obj/hud/inventory/proc/grab_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!object.can_be_grabbed(caller))
		caller.to_chat(span("notice","You cannot grab this!"))
		return FALSE

	if(length(held_objects))
		caller.to_chat(span("notice","You need an empty hand to grab this!"))
		return FALSE

	caller.to_chat(span("notice","You grab \the [object]."))
	grabbed_object = object
	update_overlays()

	return TRUE

/obj/hud/inventory/proc/release_object(var/mob/caller as mob)
	caller.to_chat(span("notice","You release \the [grabbed_object]."))
	grabbed_object = null
	update_overlays()
	return TRUE