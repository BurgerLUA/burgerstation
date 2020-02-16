/obj/item/hand_teleporter
	name = "hand teleporter"

	value = 150


/obj/item/hand_teleporter/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	var/turf/simulated/T = get_turf(object)

	if(!istype(T))
		return TRUE

	caller.force_move(T)

	return TRUE