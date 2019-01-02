/turf/can_not_enter(var/atom/A,var/move_direction)

	if(src.density) //If you're stuck because of some odd bullshit.
		return src

	if(move_direction & NORTH)
		if(src.density_north)
			return src
		if(src.density_south)
			return src
	if(move_direction & EAST)
		if(src.density_east)
			return src
		if(src.density_west)
			return src
	if(move_direction & SOUTH)
		if(src.density_south)
			return src
		if(src.density_north)
			return src
	if(move_direction & WEST)
		if(src.density_west)
			return src
		if(src.density_east)
			return src

	for(var/atom/C in contents)
		var/atom/R = C.can_not_enter(A,move_direction)
		if(R)
			return R

	return FALSE

/turf/do_bump(var/atom/bumper)
	return FALSE