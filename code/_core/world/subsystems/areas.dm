/subsystem/area
	name = "Area Subsystem"
	desc = "Manages the icon states of areas, aka weather and climate."
	priority = SS_ORDER_AREAS
	tick_rate = SECONDS_TO_TICKS(600) //Weather is 10 minute intervals

	var/list/area/areas_rain = list()
	var/list/area/areas_snow = list()
	var/list/area/areas_sandstorm = list()

	var/is_raining = TRUE
	var/is_snowing = TRUE
	var/is_sandstorming = TRUE

/subsystem/area/Initialize()

	if(!ENABLE_WEATHERGEN)
		return

	var/area_count = 0

	for(var/area/A in world)
		A.Initialize()
		area_count += 1

		if(A.weather)
			A.invisibility = 0
			A.alpha = 0
			switch(A.weather)
				if(WEATHER_SNOW)
					areas_snow += A
				if(WEATHER_RAIN)
					areas_rain += A
				if(WEATHER_SANDSTORM)
					areas_sandstorm += A

	LOG_SERVER("Initialized [length(areas_snow)] snow areas.")
	LOG_SERVER("Initialized [length(areas_rain)] rain areas.")
	LOG_SERVER("Initialized [length(areas_sandstorm)] sandstorm areas.")
	LOG_SERVER("Initialized [area_count] total areas.")

	set_weather(WEATHER_RAIN,is_raining,areas_rain)
	set_weather(WEATHER_SNOW,is_snowing,areas_snow)
	set_weather(WEATHER_SANDSTORM,is_sandstorming,areas_sandstorm)

/subsystem/area/on_life()

	if(prob(is_raining ? WEATHER_REMOVE_CHANCE : WEATHER_ADD_CHANCE))
		is_raining = !is_raining
		set_weather(WEATHER_RAIN,is_raining,areas_rain)

	if(prob(is_snowing ? WEATHER_REMOVE_CHANCE : WEATHER_ADD_CHANCE))
		is_snowing = !is_snowing
		set_weather(WEATHER_SNOW,is_snowing,areas_snow)

	if(prob(is_sandstorming ? WEATHER_REMOVE_CHANCE : WEATHER_ADD_CHANCE))
		is_sandstorming = !is_sandstorming
		set_weather(WEATHER_SANDSTORM,is_sandstorming,areas_sandstorm)

	return TRUE

/subsystem/area/proc/set_weather(var/weather_type,var/enabled=FALSE,var/list/area/world/affected_areas)
	for(var/area/A in affected_areas)
		if(enabled)
			A.icon = 'icons/area/weather.dmi'
			A.icon_state = weather_type
			A.color = "#000000"
			switch(weather_type)
				if(WEATHER_RAIN)
					animate(A,alpha=100,color="#429FCE",time=SECONDS_TO_DECISECONDS(10))
				if(WEATHER_SNOW)
					animate(A,alpha=255,color="#FFFFFF",time=SECONDS_TO_DECISECONDS(10))
				if(WEATHER_SANDSTORM)
					animate(A,alpha=255,color="#E5CDA7",time=SECONDS_TO_DECISECONDS(5))

		else
			animate(A,alpha=0,time=SECONDS_TO_DECISECONDS(10))
