/area/world/jungle //2,1
	name = "magic jungle"
	id = "jungle"

/area/world/jungle/exterior
	name = "rain"
	icon_state = "red"
	weather = WEATHER_RAIN

	sunlight_freq = 8

	desired_light_range = 8
	desired_light_power = 1
	desired_light_color = "#29332C"

/area/world/jungle/exterior/setup_sunlight(var/turf/T)

	if(istype(T,/turf/simulated/floor/river))

		if( (T.x % floor(sunlight_freq*0.75)) || (T.y % floor(sunlight_freq*0.75)) )
			return FALSE

		T.set_light(sunlight_freq+1,desired_light_power,"#213A68")
		return TRUE

	else if(istype(T,/turf/simulated/floor/lava/))

		if( (T.x % floor(sunlight_freq*0.5)) || (T.y % floor(sunlight_freq*0.5)) )
			return FALSE

		T.set_light(sunlight_freq+1,desired_light_power,"#CE631C")
		return TRUE

	return ..()

/area/world/jungle/exterior/water

	icon_state = "yellow"

	sunlight_freq = 2

	desired_light_range = 2
	desired_light_power = 1
	desired_light_color = "#213A68"


/area/world/jungle/cave
	name = "jungle cave"
	icon_state = "green"


/area/world/jungle/cave/clockwork_cave
	name = "clockwork cave"
	icon_state = "safe"
	safe = TRUE

/area/world/jungle/village
	name = "village"
	icon_state = "safe"
	weather = WEATHER_RAIN
	safe = TRUE

/area/world/jungle/exterior/village
	name = "village"
	icon_state = "safe"
	weather = WEATHER_RAIN
	safe = TRUE