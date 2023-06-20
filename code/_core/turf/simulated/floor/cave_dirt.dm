/turf/simulated/floor/cave_dirt

	name = "tough dirt"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "dirt"

	real_icon = 'icons/turf/floor/dirt.dmi'
	real_icon_state = "floor"

	corner_icons = TRUE
	corner_category = "dirt"

	plane = PLANE_FLOOR
	layer = LAYER_FLOOR

	footstep = /footstep/asteroid

	move_delay_modifier = 1

	organic = TRUE

	map_color = COLOR_BROWN

	destruction_turf = /turf/simulated/openspace


//WAY too detailed. Don't use.
/turf/simulated/floor/desert_rock

	name = "desert rock floor"

	icon = 'icons/turf/floor/cave_dirt_new.dmi'
	icon_state = "0,0"

	plane = PLANE_FLOOR
	layer = LAYER_FLOOR - 0.1

	footstep = /footstep/asteroid

	move_delay_modifier = 0.95

	destruction_turf = null

	organic = TRUE

	map_color = COLOR_BROWN

/turf/simulated/floor/desert_rock/New(var/desired_loc)
	var/desired_x = x % 10
	var/desired_y = y % 10
	icon_state = "[desired_x],[desired_y]"
	. = ..()