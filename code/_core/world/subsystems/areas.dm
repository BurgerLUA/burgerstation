/subsystem/weather
	name = "Weather and Climate Subsystem"
	desc = "Manages the icon states of areas, aka weather and climate."
	priority = SS_ORDER_WEATHER
	tick_rate = SECONDS_TO_TICKS(600) //Weather is 10 minute intervals
	var/list/area/world/areas_rain = list()
	var/list/area/world/areas_snow = list()

	var/is_raining = FALSE
	var/is_snowing = FALSE

/subsystem/weather/Initialize()

	if(!ENABLE_WEATHERGEN)
		return

	var/area_count = 0

	for(var/area/world/A in world)
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

	LOG_SERVER("Initialized [area_count] areas.")

/subsystem/weather/on_life()

	if(prob(is_raining ? 25 : 75))
		is_raining = !is_raining
		set_weather(WEATHER_RAIN,is_raining,areas_rain)

	if(prob(is_snowing ? 25 : 75))
		is_snowing = !is_snowing
		set_weather(WEATHER_SNOW,is_snowing,areas_snow)

	return TRUE

/subsystem/weather/proc/set_weather(var/weather_type,var/enabled=FALSE,var/list/area/world/affected_areas)
	for(var/area/world/A in affected_areas)
		if(enabled)
			A.icon = 'icons/area/weather.dmi'
			A.icon_state = weather_type
			A.color = "#000000"
			switch(weather_type)
				if(WEATHER_RAIN)
					animate(A,alpha=100,color="#429FCE",time=SECONDS_TO_DECISECONDS(10))
				if(WEATHER_SNOW)
					animate(A,alpha=255,color="#FFFFFF",time=SECONDS_TO_DECISECONDS(10))

		else
			animate(A,alpha=0,time=SECONDS_TO_DECISECONDS(10))
