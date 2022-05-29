/turf/simulated/floor/cave_dirt

	name = "cave dirt"

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

	health = null

	organic = TRUE

	map_color = COLOR_BROWN


/turf/simulated/floor/bedrock

	name = "bedrock"

	icon = 'icons/turf/floor/cave_dirt_new.dmi'
	icon_state = "0,0"

	plane = PLANE_FLOOR
	layer = 0

	footstep = /footstep/asteroid

	move_delay_modifier = 0.95

	health = null

	organic = TRUE

	map_color = COLOR_BROWN

/turf/simulated/floor/bedrock/New(var/desired_loc)
	var/desired_x = x % 10
	var/desired_y = y % 10
	icon_state = "[desired_x],[desired_y]"
	. = ..()