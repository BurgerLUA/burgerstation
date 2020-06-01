/area/exterior/
	sunlight_freq = 8
	desired_light_range = 9
	desired_light_power = 1

/area/exterior/snow
	name = "snow"
	icon_state = "snow"
	weather = WEATHER_SNOW
	ambient_temperature = T0C - 20
	hazard = "cold"
	desired_light_color = "#898989"

	cheese_type = /reagent/nutrition/cheese/raclette

/area/exterior/grass
	name = "grass"
	icon_state = "grass"
	desired_light_color = "#CCB06A"

	cheese_type = /reagent/nutrition/cheese/cheddar

/area/exterior/grass/village
	name = "village"
	icon_state = "village"
	defend = TRUE

/area/exterior/river
	name = "river"
	icon_state = "river"
	desired_light_color = "#6D95A5"


/area/exterior/jungle
	name = "jungle"
	icon_state = "jungle"
	weather = WEATHER_RAIN
	ambient_temperature = T0C + 40

	desired_light_range = 8
	desired_light_power = 1
	desired_light_color = "#29332C"

	cheese_type = /reagent/nutrition/cheese/brabander


/area/exterior/jungle/setup_sunlight(var/turf/T)

	if(istype(T,/turf/simulated/floor/river))

		if( (T.x % FLOOR(sunlight_freq*0.75, 1)) || (T.y % FLOOR(sunlight_freq*0.75, 1)) )
			return FALSE

		T.set_light(sunlight_freq+1,desired_light_power,"#213A68")
		return TRUE

	else if(istype(T,/turf/simulated/floor/lava/))

		if( (T.x % FLOOR(sunlight_freq*0.5, 1)) || (T.y % FLOOR(sunlight_freq*0.5, 1)) )
			return FALSE

		T.set_light(sunlight_freq+1,desired_light_power,"#CE631C")
		return TRUE

	return ..()


/area/exterior/desert
	name = "desert"
	icon_state = "desert"
	weather = WEATHER_SANDSTORM
	ambient_temperature = T0C + 80

	desired_light_range = 8
	desired_light_power = 1
	desired_light_color = "#724C2B"

	cheese_type = /reagent/nutrition/cheese/kadchgall