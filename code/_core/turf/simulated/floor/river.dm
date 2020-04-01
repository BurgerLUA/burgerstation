/turf/simulated/floor/river
	name = "river"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater_static"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	desired_light_power = 0.05
	desired_light_range = 8
	desired_light_color = "#AAAAFF"

	footstep_id = "water"

	density_north = TRUE
	density_east = TRUE
	density_south = TRUE
	density_west = TRUE

/turf/simulated/floor/river/walkable
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	footstep_id = "wood"


/turf/simulated/floor/river/chocolate
	name = "chocolate river"
	icon_state = "chocolatewater"