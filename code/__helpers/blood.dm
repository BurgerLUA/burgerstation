#define BLOOD_LIMIT 3

/proc/create_blood(var/obj/effect/desired_effect, var/turf/simulated/desired_loc,var/desired_color = "#FFFFFF",var/desired_x,var/desired_y,var/bypass_blood_limit=FALSE)

	if(!istype(desired_loc))
		return null

	if(!bypass_blood_limit && desired_loc.blood_level > BLOOD_LIMIT)
		return null

	desired_effect = new desired_effect(desired_loc,desired_color,desired_x,desired_y)
	desired_loc.blood_level++

	queue_delete(desired_effect,ITEM_DELETION_TIME_DROPPED,TRUE)

	return desired_effect