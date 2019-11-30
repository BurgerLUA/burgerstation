/turf/simulated/floor/chasm/
	name = "chasm"

	icon = 'icons/turf/floor/holes.dmi'
	icon_state = "floor"

	corner_icons = TRUE
	corner_category = "chasm"

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE
	density_up    = TRUE
	density_down  = TRUE
	allow_bullet_pass = TRUE

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

/turf/simulated/floor/chasm/end/
	name = "end of the world"