/area/world/desert //3,1
	name = "the desert"
	id = "desert"


/area/world/desert/exterior
	name = "sandstorm"
	icon_state = "red"

	area_light_power = DEFAULT_BRIGHTNESS_MUL_EXTERIOR
	icon_state = "red"

	sunlight_freq = 6

	desired_light_range = 7
	desired_light_power = 1
	desired_light_color = "#A06A33"


/area/world/desert/exterior/village/
	name = "village exterior"
	icon_state = "safe"
	safe = TRUE

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
	name = "cave"
	icon_state = "green"