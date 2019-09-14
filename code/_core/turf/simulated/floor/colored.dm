/turf/simulated/floor/colored/
	name = "colored floor"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "colored"


	real_icon = 'icons/turf/floor/ground.dmi'
	real_icon_state = "floor"
	corner_icons = TRUE

/turf/simulated/floor/colored/snow
	name = "snow"
	color = "#FFFFFF"
	layer = LAYER_FLOOR_WEATHER
	corner_category = "snow"
	light_color = "#FDFFFC"

	has_footprints = TRUE

/turf/simulated/floor/colored/grass
	name = "grass"
	color = "#44683B"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"
	light_color = "#CCFFBF"

/*
/turf/simulated/floor/colored/grass/New(loc)
	var/lightness = 104
	lightness += rand(-5,0)
	color = rgb(68,lightness,59)
	..()
*/


/turf/simulated/floor/colored/jungle_grass
	name = "jungle grass"
	color = "#27512E"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "jungle_grass"
	light_color = "#27512E"
/*
/turf/simulated/floor/colored/jungle_grass/New(loc)

	var/r = 39
	var/g = 81
	var/b = 46

	r += rand(-10,0)
	g += rand(-10,0)
	b += rand(-10,0)

	color = rgb(r,g,b)
	..()
*/

/turf/simulated/floor/colored/dark_grass
	name = "dark grass"
	color = "#527F3F"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"
	light_color = "#527F3F"

/*
/turf/simulated/floor/colored/dark_grass/New(loc)
	var/r = 82
	var/g = 127
	var/b = 63

	r += rand(-10,0)
	g += rand(-10,0)
	b += rand(-10,0)

	color = rgb(r,g,b)
	..()
*/

/turf/simulated/floor/colored/mint_grass
	name = "mint grass"
	color = "#47E059"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"
	light_color = "#47E059"


/turf/simulated/floor/colored/necro_grass
	name = "dark grass"
	color = "#393317"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"
	light_color = "#393317"


/turf/simulated/floor/colored/sand
	name = "grey sand"
	color = "#80806D"
	layer = LAYER_FLOOR_LARGE + 0.09
	corner_category = "sand"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"
	light_color = "#80806D"

/turf/simulated/floor/colored/moss
	name = "moss"
	color = "#5A916E"
	layer = LAYER_FLOOR_LARGE + 0.08
	corner_category = "moss"




	light_color = "#5A916E"

/turf/simulated/floor/colored/dirt
	name = "dirt"
	color = "#5B4128"
	layer = LAYER_FLOOR_LARGE + 0.01
	corner_category = "dirt_soft"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"

	light_color = "#FFD3AA"

/turf/simulated/floor/colored/dirt/cave
	name = "cave dirt"
	color = "#493C2F"
	corner_category = "dirt_cave"

	light_color = "#FFE8D1"
	layer = LAYER_FLOOR_LARGE

/turf/simulated/floor/colored/dirt/snow
	name = "frosty dirt"
	color = "#C6B4A9"
	light_color = "#C6B4A9"

/turf/simulated/floor/colored/dirt/jungle
	name = "jungle dirt"
	color = "#4C2C1D"
	light_color = "#4C2C1D"

/turf/simulated/floor/colored/dirt/cake
	name = "cake"
	color = "#F779E6"
	corner_category = "cake"

	layer = LAYER_FLOOR_LARGE + 0.01

	light_power = DEFAULT_BRIGHTNESS_AMBIENT
	light_range = DEFAULT_RANGE_AMBIENT
	light_color = "#F779E6"

/turf/simulated/floor/colored/dirt/cake_icing
	name = "cake"
	color = "#FFF4C1"
	corner_category = "cake_icing"

	layer = LAYER_FLOOR_LARGE

	light_power = DEFAULT_BRIGHTNESS_AMBIENT
	light_range = DEFAULT_RANGE_AMBIENT
	light_color = "#FFF4C1"

/turf/simulated/floor/colored/sand/beach
	name = "beach sand"
	color = "#FFE36B"
	light_color = "#FFE36B"

/turf/simulated/floor/colored/sand/underwater
	name = "bed sand"
	color = "#AECA91"
	light_color = "#AECA91"


/turf/simulated/floor/colored/sand/desert
	name = "desert sand"
	color = "#FFC68C"
	light_color = "#FFC68C"

/turf/simulated/floor/colored/ash/
	name = "ash"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "ash"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"
	corner_icons = TRUE
	corner_category = "ash"

/turf/simulated/floor/colored/ash/grey
	name = "ancient ash"
	color = "#5E5D77"
	light_color = "#CBC9FF"

/turf/simulated/floor/colored/ash/necro
	name = "necro ash"
	color = "#211811"
	light_color = "#FFB984"
	light_power = DEFAULT_BRIGHTNESS_AMBIENT_STRONG

/turf/simulated/floor/colored/ash/dark
	name = "volcanic ash"
	color = "#3F3F3F"

/turf/simulated/floor/colored/ash/rocky
	name = "rocky ash"
	color = "#563F2D"
	icon_state = "ash_rocky"


	real_icon = 'icons/turf/floor/rocky_ash.dmi'

	layer = LAYER_FLOOR_LARGE + 0.1

	light_color = "#563F2D"
	light_power = DEFAULT_BRIGHTNESS_AMBIENT_STRONG