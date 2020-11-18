/turf/simulated/wall/
	name = "WALL"
	desc = "A wall"
	layer = LAYER_WALL
	plane = PLANE_WALL
	opacity = 1

	density_north = TRUE
	density_east = TRUE
	density_south = TRUE
	density_west = TRUE
	density_up = TRUE
	density_down = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density = TRUE

/turf/simulated/wall/is_occupied()
	return src