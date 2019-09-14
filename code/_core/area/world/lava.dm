/area/world/lava //1,3; 1,4; 2,3
	name = "lavaland"
	id = "lavaland"
	tracks = ("lava")

/area/world/lava/exterior
	name = "lavaland exterior"
	icon_state = "red"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_EXTERIOR

/area/world/lava/interior



/area/world/lava/exterior/chapel
	name = "chapel"
	icon_state = "safe"
	safe = TRUE

/area/world/lava/interior/chapel
	name = "chapel shop"
	icon_state = "shop"
	id = "chapel_shop"
	safe = TRUE

/area/world/lava/lab
	name = "the lab"
	icon_state = "green"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR

/area/world/lava/safezone
	name = "lavaland safezone"
	icon_state = "safe"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR