/area/world/caves //2,2
	name = "caves"
	id = "caves"
	tracks = TRACKS_CAVE

/area/world/caves/interior
	name = "cave interior"
	icon_state = "orange"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR

/area/world/caves/interior/safe
	name = "cave interior safezone"
	icon_state = "safe"
	safe = TRUE

/area/world/caves/interior/dionae
	name = "cave interior"
	icon_state = "red"
	safe = TRUE

	sunlight_freq = 2

	desired_light_range = 2
	desired_light_power = 1
	desired_light_color = COLOR_DIONA_GREEN_DARK

/area/world/caves/exterior
	name = "cave exterior"
	icon_state = "green"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR

	sunlight_freq = 6

	desired_light_range = 7
	desired_light_power = 1
	desired_light_color = "#847B52"

/area/world/caves/exterior/safe
	name = "cave exterior savezone"
	icon_state = "safe"
	safe = TRUE

/area/world/caves/interior/safe/shop
	name = "cave interior shop"
	id = "cave_shop"
	icon_state = "shop"
	safe = TRUE

/area/world/caves/interior/water
	name = "water"
	icon_state = "pink"


	sunlight_freq = 2

	desired_light_range = 2
	desired_light_power = 1
	desired_light_color = "#213A68"