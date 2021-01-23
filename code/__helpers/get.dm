/proc/mobs_in_range(var/range = VIEW_RANGE,var/atom/A = usr)
	. = list()
	var/turf/T = get_turf(A)
	for(var/k in all_mobs)
		var/mob/M = k
		if(get_dist(T,M) <= range)
			. += M
	return .
