/turf/simulated/hazard/water
	name = "water"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater_static"

	collision_flags = FLAG_COLLISION_WALKING | FLAG_COLLISION_CRAWLING
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	footstep = /footstep/water

	density_north = TRUE
	density_east = TRUE
	density_south = TRUE
	density_west = TRUE

	plane = PLANE_FLOOR

	desired_light_frequency = 4
	desired_light_power = 0.5
	desired_light_range = 8
	desired_light_color = "#158996"

	water_reagent = /reagent/nutrition/water
	reagents = /reagent_container/turf/

/turf/simulated/hazard/water/sea
	name = "salty water"
