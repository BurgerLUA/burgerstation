/area/exterior/jungle
	name = "jungle"
	icon_state = "jungle"
	weather = WEATHER_RAIN
	ambient_temperature = T0C + 40

	desired_light_range = 8
	desired_light_power = 1
	desired_light_color = "#29332C"

	cheese_type = /reagent/nutrition/cheese/brabander

	//ambient_sound = 'sound/ambient/crickets.ogg'

	random_sounds = list(
		'sound/ambient/ambiruin_1.ogg',
		'sound/ambient/ambiruin_2.ogg',
		'sound/ambient/ambiruin_3.ogg',
		'sound/ambient/ambiruin_4.ogg',
		'sound/ambient/ambiruin_5.ogg',
		'sound/ambient/ambiruin_6.ogg',
		'sound/ambient/ambiruin_7.ogg',
	)

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