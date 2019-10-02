/obj/structure/
	name = "structure"
	desc = "Some kind of strange structure."
	collision_flags = FLAG_COLLISION_NONE
	anchored = 1

	var/density_north = TRUE
	var/density_south = TRUE
	var/density_east  = TRUE
	var/density_west  = TRUE

/obj/structure/Cross(var/atom/movable/O)

	if(O.collision_flags & src.collision_flags)

		var/turf/old_loc = get_turf(O)
		var/turf/new_loc = get_turf(src)

		var/direction = get_dir(old_loc,new_loc)

		if((direction & NORTH) && density_south)
			return FALSE

		if((direction & SOUTH) && density_north)
			return FALSE

		if((direction & EAST) && density_west)
			return FALSE

		if((direction & WEST) && density_east)
			return FALSE

	return TRUE

/obj/structure/Uncross(var/atom/movable/O,var/new_loc)

	if(O.collision_flags & src.collision_flags && !(density_south && density_north && density_west && density_east) )

		var/turf/old_loc = get_turf(O)

		var/direction = get_dir(old_loc,new_loc)

		if((direction & NORTH) && density_north)
			return FALSE

		if((direction & SOUTH) && density_south)
			return FALSE

		if((direction & EAST) && density_east)
			return FALSE

		if((direction & WEST) && density_west)
			return FALSE


	return TRUE