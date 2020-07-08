/proc/get_turf(A)
	return get_step(A,0)

/proc/get_area(A)
	if(isarea(A))
		return A
	var/turf/T = get_turf(A)
	return T ? T.loc : null

/proc/get_dist_advanced(var/atom/A1,var/atom/A2)

	var/best_distance = get_dist(A1,A2)

	if(is_living(A1) && is_living(A2))
		var/mob/living/L1 = A1
		var/mob/living/L2 = A2
		if(L1.move_delay > 0 && L2.move_delay > 0)
			var/calc1 = get_dist(L1.old_turf,L2)
			var/calc2 = get_dist(L1,L2.old_turf)
			if(calc1 < best_distance)
				best_distance = calc1
			if(calc2 < best_distance)
				best_distance = calc1
		else if(L1.move_delay > 0)
			var/calc = get_dist(L1.old_turf,L2)
			if(calc < best_distance)
				best_distance = calc

		else if(L2.move_delay > 0)
			var/calc = get_dist(L1,L2.old_turf)
			if(calc < best_distance)
				best_distance = calc

	best_distance -= ( (A1.object_size-1) + (A2.object_size-1) )

	return best_distance

/proc/get_dist_real(var/atom/A1,var/atom/A2)
	return sqrt( ((A1.x - A2.x)**2) + ((A1.y - A2.y)**2) )