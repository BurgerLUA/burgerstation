#define get_area(A) (get_step(A, 0).loc) //This helper is so fucking weird.

#define get_turf(A) (get_step(A, 0)) //This helper is so fucking weird.

/proc/get_dist_between_living(var/mob/living/L1,var/mob/living/L2)

	var/best_distance = get_dist(L1,L2)

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

	return best_distance