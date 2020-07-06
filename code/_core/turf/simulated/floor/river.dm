/turf/simulated/floor/river
	name = "river"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater_static"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	footstep = /footstep/water

	density_north = TRUE
	density_east = TRUE
	density_south = TRUE
	density_west = TRUE

	plane = PLANE_WATER

	desired_light_frequency = 4
	desired_light_power = 0.5
	desired_light_range = 8
	desired_light_color = "#158996"

/turf/simulated/floor/river/walkable
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE


/turf/simulated/floor/river/chocolate
	name = "chocolate river"
	icon_state = "chocolatewater"


/turf/simulated/floor/water
	name = "water"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater_static"
	footstep = /footstep/water
	water_reagent = /reagent/nutrition/water
	reagents = /reagent_container/turf/