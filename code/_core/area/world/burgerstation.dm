/area/world/burgerstation //4,4
	name = "burgerstation"
	id = "burgerstation"
	safe = TRUE

/area/world/burgerstation/interior
	name = "burgerstation interior"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR
	icon_state = "green"

/area/world/burgerstation/interior/shuttle
	name = "shuttle"


/area/world/burgerstation/interior/home
	name = "home"
	singleplayer = TRUE
	safe = TRUE

/area/world/burgerstation/interior/nothing
	name = "nothing"
	singleplayer = TRUE
	//assoc_wishgranter = "main"


/area/world/burgerstation/exterior
	name = "burgerstation exterior"
	icon_state = "red"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_EXTERIOR


/area/world/burgerstation/exterior/space
	name = "space"
	icon_state = "blue"

	sunlight_freq = 2

	desired_light_range = 2
	desired_light_power = 1
	desired_light_color = COLOR_SPACE_LIGHT


/area/world/burgerstation/interior/fire
	name = "oh god oh fuck"

	sunlight_freq = 3

	desired_light_range = 8
	desired_light_power = 1
	desired_light_color = COLOR_ORANGE

/area/world/burgerstation/interior/shop/
	name = "Coderbus"
	id = "coderbus"
	safe = TRUE
	icon_state = "shop"

	sunlight_freq = 3

	desired_light_range = 3
	desired_light_power = 1
	desired_light_color = "#1E6489"

