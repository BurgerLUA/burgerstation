/proc/mobs_in_range(range = VIEW_RANGE,atom/A = usr)
	. = list()
	var/turf/T = get_turf(A)
	for(var/k in SSliving.all_mobs)
		var/mob/M = k
		if(get_dist(T,M) <= range)
			. += M
