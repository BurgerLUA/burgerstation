/turf/simulated/floor/basalt/
	name = "basalt"

	icon = 'icons/turf/floor/basalt.dmi'
	icon_state = "basalt0"

	real_icon = 'icons/turf/floor/basalt_smooth.dmi'
	real_icon_state = "floor"

	corner_icons = TRUE
	corner_category = "basalt"

	layer = LAYER_FLOOR_LARGE + 0.2

	footstep = /footstep/concrete

	delay_modifier = 1.1

/turf/simulated/floor/basalt/New(var/desired_loc)
	icon_state = "basalt [rand(1,15)]"
	. = ..()
