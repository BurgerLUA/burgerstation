/turf/simulated/floor/colored/
	name = "colored floor"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "colored"

	real_icon = 'icons/turf/floor/ground.dmi'
	real_icon_state = "grass"
	corner_icons = TRUE

/turf/simulated/floor/colored/snow
	name = "snow"
	color = "#FFFFFF"
	layer = LAYER_FLOOR_WEATHER
	corner_category = "snow"

	footstep = /footstep/snow

	delay_modifier = 1.2

	material_id = /material/dirt/

	destruction_turf = /turf/simulated/floor/colored/dirt/snow

/turf/simulated/floor/colored/grass
	name = "grass"
	color = "#44683B"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"

	fade = TRUE

	footstep = /footstep/grass

	destruction_turf = /turf/simulated/floor/colored/dirt

	delay_modifier = 1.05

	material_id = /material/grass/

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

	destruction_turf = /turf/simulated/floor/colored/dirt/jungle

/turf/simulated/floor/colored/grass/mint
	name = "mint grass"
	color = "#47E059"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"

/turf/simulated/floor/colored/grass/necro
	name = "dark grass"
	color = "#393317"
	layer = LAYER_FLOOR_LARGE + 0.1
	corner_category = "grass"


/turf/simulated/floor/colored/sand
	name = "grey sand"
	color = "#80806D"
	layer = LAYER_FLOOR_LARGE + 0.09
	corner_category = "sand"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"

	footstep = /footstep/asteroid

	delay_modifier = 1.1

	material_id = /material/dirt/

/turf/simulated/floor/colored/sand/oasis
	name = "sand"
	color = "#CCBC8A"


/turf/simulated/floor/colored/grass/moss
	name = "moss"
	color = "#5A916E"
	layer = LAYER_FLOOR_LARGE + 0.08
	corner_category = "moss"

/turf/simulated/floor/colored/dirt
	name = "dirt"
	color = "#5B4128"
	layer = LAYER_FLOOR_LARGE + 0.02
	corner_category = "dirt_soft"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"

	footstep = /footstep/asteroid

	destruction_turf = /turf/simulated/floor/colored/dirt/soil

	delay_modifier = 1.05

	material_id = /material/dirt/

/turf/simulated/floor/colored/dirt/cave
	name = "dirt"
	color = "#493C2F"
	corner_category = "dirt_cave"

	layer = LAYER_FLOOR_LARGE

	destruction_turf = /turf/simulated/floor/cave_dirt/

/turf/simulated/floor/colored/dirt/snow
	name = "frosty dirt"
	color = "#C6B4A9"

/turf/simulated/floor/colored/dirt/jungle
	name = "jungle dirt"
	color = "#4C403A"

/turf/simulated/floor/colored/dirt/soil
	name = "soil"
	color = "#3D2414"
	desired_light_color = "#3D2414"
	corner_category = "soil"
	layer = LAYER_FLOOR_LARGE + 0.01

	destruction_turf = /turf/simulated/floor/colored/dirt/cave

/turf/simulated/floor/colored/dirt/cake
	name = "cake"
	color = "#F779E6"
	corner_category = "cake"

	layer = LAYER_FLOOR_LARGE + 0.01

/turf/simulated/floor/colored/dirt/cake_icing
	name = "cake"
	color = "#FFF4C1"
	corner_category = "cake_icing"

	layer = LAYER_FLOOR_LARGE

/turf/simulated/floor/colored/sand/beach
	name = "beach sand"
	color = "#FFE36B"

/turf/simulated/floor/colored/sand/underwater
	name = "bed sand"
	color = "#AECA91"


/turf/simulated/floor/colored/sand/desert
	name = "sand"
	//color = "#FFC68C"
	color = "#AE8A67"

/turf/simulated/floor/colored/ash/
	name = "ash"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "ash"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"
	corner_icons = TRUE
	corner_category = "ash"

	footstep = /footstep/asteroid

	delay_modifier = 1.1

	layer = LAYER_FLOOR_LARGE + 0.3

	material_id = /material/dirt/

/turf/simulated/floor/colored/ash/grey
	name = "ancient ash"
	color = "#5E5D77"

/turf/simulated/floor/colored/ash/necro
	name = "necro ash"
	color = "#211811"

/turf/simulated/floor/colored/ash/dark
	name = "volcanic ash"
	color = "#3F3F3F"

/turf/simulated/floor/colored/ash/rocky
	name = "rocky ash"
	color = "#563F2D"
	icon_state = "ash_rocky"

	real_icon = 'icons/turf/floor/rocky_ash.dmi'

	layer = LAYER_FLOOR_LARGE + 0.1

