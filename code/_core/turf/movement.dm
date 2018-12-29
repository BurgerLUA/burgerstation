/turf/proc/can_pass(var/atom/A,var/move_dir)

	var/turf/start = get_turf(A)

	if(!start)
		return TRUE

	if(start.density) //If you're stuck because of some odd bullshit.
		return !src.density

	if(move_dir & NORTH)
		if(start.density_north)
			return FALSE
		if(src.density_south)
			return FALSE
	if(move_dir & EAST)
		if(start.density_east)
			return FALSE
		if(src.density_west)
			return FALSE
	if(move_dir & SOUTH)
		if(start.density_south)
			return FALSE
		if(src.density_north)
			return FALSE
	if(move_dir & WEST)
		if(start.density_west)
			return FALSE
		if(src.density_east)
			return FALSE

	return TRUE