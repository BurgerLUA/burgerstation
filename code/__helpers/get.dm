/proc/mobs_in_range(var/range = VIEW_RANGE,var/turf/T = get_turf(usr))
	. = list()
	for(var/k in all_mobs)
		var/mob/M = k
		if(get_dist(T,M) <= range)
			. += M
	return .
