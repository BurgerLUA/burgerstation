/obj/structure/
	name = "structure"
	desc = "Some kind of strange structure."
	collision_flags = FLAG_COLLISION_NONE
	anchored = 1

	var/density_north = TRUE
	var/density_south = TRUE
	var/density_east  = TRUE
	var/density_west  = TRUE

	var/bullet_block_chance = 100 //Chance to block bullets.

/obj/structure/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	var/projectile_dir = get_dir(old_turf,new_turf)

	if(prob(max(0,100-bullet_block_chance)))
		return FALSE

	if((projectile_dir & NORTH) && src.density_south)
		return src
	else if((projectile_dir & SOUTH) && src.density_north)
		return src

	if((projectile_dir & EAST) && src.density_west)
		return src
	else if((projectile_dir & WEST) && src.density_east)
		return src

	return FALSE

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