/area/world/
	name = "the world"
	dynamic_lighting = TRUE
	var/weather = WEATHER_NONE //Optional weather

/area/world/Initialize()
	. = ..()
	if(weather)
		icon = 'icons/area/weather.dmi'
		icon_state = weather
	return .

/area/world/shadows //2,4
	name = "shadow realm"

/area/world/core //3,4
	name = "the core"

/area/world/temple02 //4,1
	name = "moth temple"

/area/world/admin //4,3
	name = "admin area"









