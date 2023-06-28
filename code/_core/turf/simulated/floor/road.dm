/turf/simulated/floor/road
	name = "road"
	icon = 'icons/turf/floor/road.dmi'
	icon_state = "road"

	footstep = /footstep/concrete

	map_color = COLOR_GREY_DARK

	health_base = 500

	layer = LAYER_FLOOR_ROAD

/turf/simulated/floor/sidewalk
	name = "sidewalk"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "sidewalk"

	real_icon = 'icons/turf/floor/sidewalk_new.dmi'
	real_icon_state = "sidewalk"

	corner_icons = TRUE
	corner_category = "curb"

	footstep = /footstep/concrete

	map_color = COLOR_GREY

	layer = LAYER_FLOOR_SIDEWALK

	health_base = 400

/turf/simulated/floor/sidewalk/should_smooth_with(var/turf/simulated/T)
	return T.type != /turf/simulated/floor/road

/turf/simulated/floor/sidewalk/update_overlays()

	. = ..()

	var/desired_shade_direction = 0x0

	for(var/k in DIRECTIONS_CARDINAL)
		var/turf/T = get_step(src,k)
		if(!T || T.type != src.type)
			continue
		desired_shade_direction |= k

	if((desired_shade_direction & NORTH) && (desired_shade_direction & SOUTH))
		if(x % 2)
			desired_shade_direction &= ~NORTH
		else
			desired_shade_direction &= ~SOUTH

	if((desired_shade_direction & EAST) && (desired_shade_direction & WEST))
		if(y % 2)
			desired_shade_direction &= ~EAST
		else
			desired_shade_direction &= ~WEST

	if(desired_shade_direction)
		var/image/I = new/image(initial(real_icon),"shading")
		add_overlay(I)

	src.dir = desired_shade_direction

	name = "[dir2text(desired_shade_direction)]"