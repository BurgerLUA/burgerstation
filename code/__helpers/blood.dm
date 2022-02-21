#define BLOOD_LIMIT 3 //Maximum of how many blood particles there are on a turf.

/proc/create_blood(var/obj/effect/cleanable/blood/desired_effect, var/turf/simulated/desired_loc,var/desired_color = "#FFFFFF",var/desired_x,var/desired_y,var/bypass_blood_limit=FALSE)

	if(!istype(desired_loc))
		return null

	if(!bypass_blood_limit && desired_loc.blood_level_hard > BLOOD_LIMIT)
		return null

	return new desired_effect(desired_loc,desired_color,desired_x,desired_y)