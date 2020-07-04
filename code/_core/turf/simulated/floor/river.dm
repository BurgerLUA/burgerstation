/turf/simulated/floor/river
	name = "river"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater_static"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	desired_light_power = 0.05
	desired_light_range = 8
	desired_light_color = "#AAAAFF"

	footstep = /footstep/water

	density_north = TRUE
	density_east = TRUE
	density_south = TRUE
	density_west = TRUE

	plane = PLANE_WATER


/turf/simulated/floor/river/setup_turf_light(var/sunlight_freq)
	if((src.x % FLOOR(sunlight_freq*0.5, 1)) || (src.y % FLOOR(sunlight_freq*0.5, 1)) )
		return FALSE
	src.set_light(sunlight_freq+1,0.5,"#6D95A5")
	return TRUE

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
	water_reagent = "water"
	reagents = /reagent_container/turf/