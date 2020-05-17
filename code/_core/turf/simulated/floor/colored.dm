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
	desired_light_color = "#FDFFFC"

	footstep_id = "snow"

	delay_modifier = 1.3

/turf/simulated/floor/colored/grass
	name = "grass"
	color = "#44683B"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"
	desired_light_color = "#CCFFBF"

	fade = TRUE

	footstep_id = "grass"

	destruction_turf = /turf/simulated/floor/colored/dirt

	delay_modifier = 1.1

/*
/turf/simulated/floor/colored/grass/New(loc)
	var/desired_lightness = 104
	desired_lightness += rand(-5,0)
	color = rgb(68,desired_lightness,59)
	..()
*/


/turf/simulated/floor/colored/grass/jungle
	name = "jungle grass"
	color = "#42512B"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "jungle_grass"

	footstep_id = "grass"


/turf/simulated/floor/colored/grass/dark
	name = "dark grass"
	color = "#527F3F"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"
	desired_light_color = "#527F3F"

	footstep_id = "grass"

/turf/simulated/floor/colored/grass/mint
	name = "mint grass"
	color = "#47E059"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"
	desired_light_color = "#47E059"

	footstep_id = "grass"

/turf/simulated/floor/colored/grass/necro
	name = "dark grass"
	color = "#393317"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"
	desired_light_color = "#393317"

	footstep_id = "grass"


/turf/simulated/floor/colored/sand
	name = "grey sand"
	color = "#80806D"
	layer = LAYER_FLOOR_LARGE + 0.09
	corner_category = "sand"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"
	desired_light_color = "#80806D"

	footstep_id = "asteroid"

	delay_modifier = 1.2

/turf/simulated/floor/colored/grass/moss
	name = "moss"
	color = "#5A916E"
	layer = LAYER_FLOOR_LARGE + 0.08
	corner_category = "moss"
	desired_light_color = "#5A916E"

	footstep_id = "grass"

/turf/simulated/floor/colored/dirt
	name = "dirt"
	color = "#5B4128"
	layer = LAYER_FLOOR_LARGE + 0.01
	corner_category = "dirt_soft"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"

	desired_light_color = "#FFD3AA"

	footstep_id = "asteroid"

	destruction_turf = /turf/simulated/floor/colored/dirt/soil

	delay_modifier = 1.1

/turf/simulated/floor/colored/dirt/cave
	name = "dirt"
	color = "#493C2F"
	corner_category = "dirt_cave"

	desired_light_color = "#FFE8D1"
	layer = LAYER_FLOOR_LARGE

	destruction_turf = /turf/simulated/floor/cave_dirt/

/turf/simulated/floor/colored/dirt/snow
	name = "frosty dirt"
	color = "#C6B4A9"
	desired_light_color = "#C6B4A9"

/turf/simulated/floor/colored/dirt/jungle
	name = "jungle dirt"
	color = "#4C403A"
	desired_light_color = "#4C2C1D"

/turf/simulated/floor/colored/dirt/soil
	name = "soil"
	color = "#3D2414"
	desired_light_color = "#3D2414"
	corner_category = "soil"
	layer = LAYER_FLOOR_LARGE + 0.02

	destruction_turf = /turf/simulated/floor/colored/dirt/cave

/turf/simulated/floor/colored/dirt/cake
	name = "cake"
	color = "#F779E6"
	corner_category = "cake"

	layer = LAYER_FLOOR_LARGE + 0.01

	desired_light_power = DEFAULT_BRIGHTNESS_AMBIENT
	desired_light_range = DEFAULT_RANGE_AMBIENT
	desired_light_color = "#F779E6"

/turf/simulated/floor/colored/dirt/cake_icing
	name = "cake"
	color = "#FFF4C1"
	corner_category = "cake_icing"

	layer = LAYER_FLOOR_LARGE

	desired_light_power = DEFAULT_BRIGHTNESS_AMBIENT
	desired_light_range = DEFAULT_RANGE_AMBIENT
	desired_light_color = "#FFF4C1"

/turf/simulated/floor/colored/sand/beach
	name = "beach sand"
	color = "#FFE36B"
	desired_light_color = "#FFE36B"

/turf/simulated/floor/colored/sand/underwater
	name = "bed sand"
	color = "#AECA91"
	desired_light_color = "#AECA91"


/turf/simulated/floor/colored/sand/desert
	name = "sand"
	//color = "#FFC68C"
	color = "#AE8A67"
	desired_light_color = "#FFC68C"

/turf/simulated/floor/colored/ash/
	name = "ash"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "ash"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"
	corner_icons = TRUE
	corner_category = "ash"

	footstep_id = "asteroid"

	delay_modifier = 1.2

	layer = LAYER_FLOOR_LARGE + 0.3

/turf/simulated/floor/colored/ash/grey
	name = "ancient ash"
	color = "#5E5D77"
	desired_light_color = "#CBC9FF"

/turf/simulated/floor/colored/ash/necro
	name = "necro ash"
	color = "#211811"
	desired_light_color = "#FFB984"
	desired_light_power = DEFAULT_BRIGHTNESS_AMBIENT_STRONG

/turf/simulated/floor/colored/ash/dark
	name = "volcanic ash"
	color = "#3F3F3F"

/turf/simulated/floor/colored/ash/rocky
	name = "rocky ash"
	color = "#563F2D"
	icon_state = "ash_rocky"


	real_icon = 'icons/turf/floor/rocky_ash.dmi'

	layer = LAYER_FLOOR_LARGE + 0.1

	desired_light_color = "#563F2D"
	desired_light_power = DEFAULT_BRIGHTNESS_AMBIENT_STRONG