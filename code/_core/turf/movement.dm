/*
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

	for(var/C in contents)
		var/atom/CFix = C
		var/atom/R = CFix.can_not_enter(A,move_direction)

		if(R)
			return R

	return FALSE
*/

/* TODO: CHECK THIS
/turf/can_bump(var/atom/bumper,var/bump_direction,var/movement_override = 0)
	return FALSE
*/