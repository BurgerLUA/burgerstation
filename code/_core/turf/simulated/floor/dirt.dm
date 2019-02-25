/turf/simulated/floor/cave_dirt/
	name = "dirt"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "dirt"

	real_icon = 'icons/turf/floor/dirt.dmi'
	real_icon_state = "floor"
	corner_icons = TRUE
	corner_category = "dirt"

	light_power = 0.05

	layer = LAYER_FLOOR_LARGE + 0.5

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
	layer = LAYER_FLOOR_LARGE + 0.8
	corner_category = "snow"

/turf/simulated/floor/colored/grass
	name = "grass"
	color = "#008800"
	layer = LAYER_FLOOR_LARGE + 0.9
	corner_category = "grass"

/turf/simulated/floor/colored/grass/jungle
	name = "jungle grass"
	color = "#279B3A"

/turf/simulated/floor/colored/grass/New(loc)
	var/lightness = 128
	lightness += rand(-5,0)
	color = rgb(0,lightness,0)
	..()

/turf/simulated/floor/colored/sand
	name = "grey sand"
	color = "#80806D"
	layer = LAYER_FLOOR_LARGE + 0.8
	corner_category = "sand"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"

/turf/simulated/floor/colored/moss
	name = "grass"
	color = "#5A916E"
	layer = LAYER_FLOOR_LARGE + 0.7


/turf/simulated/floor/colored/dirt
	name = "soft dirt"
	color = "#5B4128"
	layer = LAYER_FLOOR_LARGE + 0.6
	corner_category = "dirt_soft"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"

/turf/simulated/floor/colored/dirt/snow
	name = "frosty dirt"
	color = "#726253"

/turf/simulated/floor/colored/sand/beach
	name = "beach sand"
	color = "#FFE36B"

/turf/simulated/floor/colored/sand/underwater
	name = "bed sand"
	color = "#AECA91"

/turf/simulated/floor/colored/sand/desert
	name = "desert sand"
	color = "#FFC68C"
