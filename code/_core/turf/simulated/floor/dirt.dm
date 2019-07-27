/turf/simulated/floor/cave_dirt/
	name = "dirt"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "dirt"

	real_icon = 'icons/turf/floor/dirt.dmi'
	real_icon_state = "floor"
	corner_icons = TRUE
	corner_category = "dirt"

	layer = LAYER_FLOOR_LARGE

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
	light_color = "#88FFFF"


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
	light_color = "#FFE8D1"

/turf/simulated/floor/colored/dirt/snow
	name = "frosty dirt"
	color = "#C6B4A9"
	light_color = "#C6B4A9"

/turf/simulated/floor/colored/dirt/jungle
	name = "jungle dirt"
	color = "#4C2C1D"
	light_color = "#4C2C1D"

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
