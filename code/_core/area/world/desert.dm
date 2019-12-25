/area/world/desert //3,1
	name = "the desert"
	id = "desert"

	ambient_temperature = T0C + 40

	//assoc_wishgranter = "desert"

/area/world/desert/exterior/

	area_light_power = DEFAULT_BRIGHTNESS_MUL_EXTERIOR

	sunlight_freq = 6

	desired_light_range = 7
	desired_light_power = 1
	desired_light_color = "#A06A33"

/area/world/desert/exterior/combat_zone
	name = "desert"
	icon_state = "red"

	weather = WEATHER_SANDSTORM

/area/world/desert/exterior/protected
	name = "protected desert"
	icon_state = "pink"
	weather = null

	area_light_power = DEFAULT_BRIGHTNESS_MUL_EXTERIOR

	sunlight_freq = 6

	desired_light_range = 7
	desired_light_power = 1
	desired_light_color = "#A06A33"

/area/world/desert/exterior/river
	name = "mile river"
	icon_state = "blue"

	sunlight_freq = 4

	desired_light_range = 4
	desired_light_power = 1
	desired_light_color = "#1E6489"

	weather = WEATHER_SANDSTORM

/area/world/desert/exterior/river/protected
	name = "protected mile river"
	icon_state = "yellow"
	weather = null

/area/world/desert/exterior/village/
	name = "desert village"
	icon_state = "safe"
	safe = TRUE
	weather = null

/area/world/desert/exterior/village/shop01
	id = "desert_shop_01"
	icon_state = "shop"

/area/world/desert/exterior/village/shop02
	id = "desert_shop_02"
	icon_state = "shop"

/area/world/desert/exterior/village/shop03
	id = "desert_shop_03"
	icon_state = "shop"

/area/world/desert/cave
	name = "desert cave"
	icon_state = "green"