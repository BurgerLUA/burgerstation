/area/world/mountain //3,3
	name = "snowy mountain"

/area/world/mountain/interior
	name = "interior"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR
	icon_state = "green"

/area/world/mountain/exterior
	name = "exterior"
	icon_state = "red"
	weather = WEATHER_SNOW
	area_light_power = DEFAULT_BRIGHTNESS_MUL_EXTERIOR

/area/world/mountain/exterior/village
	name = "village"
	icon_state = "safe"
	safe = TRUE

/area/world/mountain/interior/bar
	name = "snow bar"
	icon_state = "green"

/area/world/mountain/interior/shack
	name = "snow shack"
	icon_state = "green"

/area/world/mountain/interior/cave
	name = "snow cave"
	icon_state = "pink"