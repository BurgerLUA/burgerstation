/* OLD MOVEMENT
/obj/inventory/proc/do_drag(var/turf/T,var/movement_override = 0)
	var/distance = get_dist(owner,grabbed_object)
	if(grabbed_object && distance > 1)
		if(distance > 2 || !grabbed_object.do_step(T,movement_override))
			release_object()
			return FALSE

	return TRUE
*/

/obj/inventory/proc/grab_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!object.can_be_grabbed())
		caller.to_chat(span("notice","You cannot grab this!"))
		return FALSE

	if(length(held_objects))
		caller.to_chat(span("notice","You cannot grab this with objects already in your hand!"))
		return FALSE

	caller.to_chat(span("notice","You grab \the [object]."))
	grabbed_object = object

	return TRUE

/obj/inventory/proc/release_object()
	grabbed_object = null
	return TRUE