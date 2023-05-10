/proc/get_area(var/datum/A)
	if(is_area(A)) return A
	var/turf/T = get_turf(A)
	return T ? T.loc : null

/proc/get_dist_real(var/atom/A1,var/atom/A2) //More intensive than get_dist, but more accurate.
	return sqrt( ((A1.x - A2.x)**2) + ((A1.y - A2.y)**2) )

/*
/proc/get_dist_advanced(var/atom/A1,var/atom/A2)

	var/best_distance = get_dist(A1,A2)

	if(is_living(A1) && is_living(A2))
		var/mob/living/L1 = A1
		var/mob/living/L2 = A2
		if(L1.next_move > 0 && L2.next_move > 0 && L1.old_turf && L2.old_turf)
			var/calc = get_dist(L2.old_turf,L1.old_turf)
			if(calc >= 0 && calc < best_distance)
				best_distance = calc
		if(L1.next_move > 0 && L1.old_turf)
			var/calc = get_dist(L1.old_turf,L2)
			if(calc >= 0 && calc < best_distance)
				best_distance = calc
		if(L2.next_move > 0 && L2.old_turf)
			var/calc = get_dist(L1,L2.old_turf)
			if(calc >= 0 && calc < best_distance)
				best_distance = calc

	best_distance -= (A1.object_size-1) + (A2.object_size-1)

	return best_distance
*/


/proc/get_dist_advanced(var/atom/A1,var/atom/A2)

	if(!A1 || !A2)
		return max(world.maxx,world.maxy)

	var/A1_x = A1.x
	var/A1_y = A1.y
	var/A1_z = A1.z
	if(A1_z == 0)
		var/turf/T = get_turf(A1)
		if(!T || T.z == 0)
			return max(world.maxx,world.maxy)
		A1_x = T.x
		A1_y = T.y
		A1_z = T.z

	var/A2_x = A2.x
	var/A2_y = A2.y
	var/A2_z = A2.z
	if(A2_z == 0)
		var/turf/T = get_turf(A2)
		if(!T || T.z == 0)
			return max(world.maxx,world.maxy)
		A2_x = T.x
		A2_y = T.y
		A2_z = T.z

	if(A1_z != A2_z)
		return max(world.maxx,world.maxy)

	if(is_living(A1))
		var/mob/living/L1 = A1
		if(L1.old_turf && L1.last_move_delay > 0 && (L1.last_move_time + L1.last_move_delay) > world.time)
			var/modifier = (world.time - L1.last_move_time)/L1.last_move_delay
			A1_x = LERP(L1.old_turf.x,A1_x,modifier)
			A1_y = LERP(L1.old_turf.y,A1_y,modifier)

	if(is_living(A2))
		var/mob/living/L2 = A2
		if(L2.old_turf && L2.last_move_delay > 0 && (L2.last_move_time + L2.last_move_delay) > world.time)
			var/modifier = (world.time - L2.last_move_time)/L2.last_move_delay
			A2_x = LERP(L2.old_turf.x,A2_x,modifier)
			A2_y = LERP(L2.old_turf.y,A2_y,modifier)

	. = max(abs(A1_x - A2_x),abs(A1_y - A2_y))
	. -= (A1.object_size-1) + (A2.object_size-1)
	. = max(0,.)


