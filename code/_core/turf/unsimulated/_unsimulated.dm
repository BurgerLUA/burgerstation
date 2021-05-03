/turf/unsimulated/
	opacity = 0

	dynamic_lighting = FALSE

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE
	density_up    = TRUE
	density_down  = TRUE
	allow_bullet_pass = FALSE

	collision_flags = FLAG_COLLISION_UNSIMULATED

/turf/unsimulated/wall
	name = "WALL ERROR"

/turf/unsimulated/floor
	name = "FLOOR ERROR"

/turf/unsimulated/abyss
	name = "abyss"
	icon = 'icons/turf/space/abyss.dmi'
	icon_state = "abyss"
	opacity = 1
	density = TRUE

	desired_light_frequency = 2
	desired_light_power = 1
	desired_light_range = 8
	desired_light_color = "#FFFFFF"

/turf/unsimulated/void
	name = "abyss"
	icon = 'icons/turf/space/void.dmi'
	icon_state = "void"
	opacity = 1