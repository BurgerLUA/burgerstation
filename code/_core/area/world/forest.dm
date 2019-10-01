/area/world/forest //3,2
	name = "forest"
	id = "forest"
	ambient_sound = 'sounds/ambient/crickets.ogg'

	map_color_r = rgb(255,0,0,255)
	map_color_g = rgb(0,255,0,255)
	map_color_b = rgb(25,25,200,255)
	map_color_a = rgb(0,0,0,255)

	tracks = list("village","rise","downwards")

/area/world/forest/interior
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR
	icon_state = "green"

/area/world/forest/exterior
	area_light_power = DEFAULT_BRIGHTNESS_MUL_EXTERIOR
	icon_state = "red"

	sunlight_freq = 4

	desired_light_range = 4
	desired_light_power = 1
	desired_light_color = "#B7AB71"

/area/world/forest/exterior/plains
	name = "forest plains"

/area/world/forest/interior/cave
	name = "caves"

/area/world/forest/interior/cave/spider
	name = "spider cave"

/area/world/forest/interior/cave/crab
	name = "lizard cave"

/area/world/forest/interior/cave/desert
	name = "desert cave"

/area/world/forest/interior/cave/open
	name = "open cave"
	icon_state = "pink"

/area/world/forest/interior/village/cave
	name = "diona's cave"
	icon_state = "pink"

/area/world/forest/exterior/village
	name = "village"
	id = "village"
	icon_state = "safe"
	safe = TRUE
	tracks = list(
		"village"
	)

/area/world/forest/exterior/village/ship
	icon_state = "pink"


/area/world/forest/interior/village
	name = "village"
	id = "village"
	icon_state = "safe"
	safe = TRUE
	tracks = list(
		"village"
	)


/area/world/forest/interior/village/shop
	name = "shop"
	icon_state = "shop"

/area/world/forest/interior/village/shop/nanotrasen
	name = "nanotrasen shop"
	id = "nanotrasen_shop"

/area/world/forest/interior/village/shop/chapel
	name = "chapel shop"
	id = "chapel_shop"

/area/world/forest/interior/village/shop/farm
	name = "farm shop"
	id = "farm_shop"

/area/world/forest/interior/village/shop/alley
	name = "alley shop"
	id = "alley_shop"

/area/world/forest/interior/village/shop/debug
	name = "debug shop"
	id = "debug_shop"


/area/world/forest/interior/village/ship
	name = "ship interior"
	icon_state = "blue"

/area/world/forest/interior/village/bar
	name = "bar"
	icon_state = "yellow"

/area/world/forest/interior/village/house
	name = "house"
	icon_state = "green"

/area/world/forest/interior/village/house/a

/area/world/forest/interior/village/house/b

/area/world/forest/interior/village/house/c

/area/world/forest/interior/village/house/d

/area/world/forest/interior/village/house/e

/area/world/forest/interior/village/house/f

/area/world/forest/interior/village/house/g