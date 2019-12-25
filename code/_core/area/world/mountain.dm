/area/world/mountain //3,3
	name = "snowy mountain"
	id = "mountain"

	//assoc_wishgranter = "northern_heights"

	tracks = TRACKS_MOUNTAIN

/area/world/mountain/interior
	name = "interior"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR
	icon_state = "green"

/area/world/mountain/exterior
	name = "exterior"
	icon_state = "yellow"
	weather = WEATHER_SNOW
	hazard = "cold"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_EXTERIOR

	sunlight_freq = 4

	desired_light_range = 8
	desired_light_power = 1
	desired_light_color = "#110D21"

	ambient_temperature = T0C - 20

/area/world/mountain/exterior/village
	name = "village"
	icon_state = "safe"
	safe = TRUE

/area/world/mountain/interior/shop
	name = "shop"
	icon_state = "shop"
	safe = TRUE

/area/world/mountain/interior/shop/gunstore
	name = "gunstore"
	id = "mountain_gunstore"
	icon_state = "shop"

/area/world/mountain/interior/shack
	name = "snow shack"
	icon_state = "green"

/area/world/mountain/interior/cave
	name = "snow cave"
	icon_state = "pink"

/area/world/mountain/interior/cave/safe
	name = "entrance cave"
	icon_state = "safe"
	safe = TRUE

/area/world/mountain/interior/temple
	name = "snow temple"
	icon_state = "green"