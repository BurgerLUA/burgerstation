/area/world/
	name = "the world"
	dynamic_lighting = TRUE
	var/weather = WEATHER_NONE //Optional weather
	light_power_mul = 1

/area/world/Initialize()
	..()
	if(weather)
		icon = 'icons/area/weather.dmi'
		icon_state = weather



/area/world/cult //1,2
	name = "cult lair"

/area/world/cult/exterior //1,2
	name = "cult exterior"
	icon_state = "blue"

/area/world/cult/exterior/safe //1,2
	name = "cult exterior wishgranter"
	icon_state = "safe2"
	safe = TRUE

/area/world/cult/interior //1,2
	name = "cult exterior"
	icon_state = "green"


/area/world/cult/interior/safe //1,2
	name = "cult wishgranter"
	icon_state = "safe"
	safe = TRUE


/area/world/shadows //2,4
	name = "shadow realm"

/area/world/core //3,4
	name = "the core"

/area/world/temple02 //4,1
	name = "moth temple"

/area/world/ocean //4,2
	name = "ocean"

/area/world/island //4,3
	name = "diona island"

/area/world/admin //4,3
	name = "admin area"









