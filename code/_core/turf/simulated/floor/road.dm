/turf/simulated/floor/road
	name = "road"
	icon = 'icons/turf/floor/road.dmi'
	icon_state = "1"

	footstep = /footstep/concrete

	map_color = COLOR_GREY_DARK

/turf/simulated/floor/road/New(var/desired_loc)
	icon_state = "[rand(1,6)]"
	. = ..()

/turf/simulated/floor/sidewalk
	name = "sidewalk"
	icon = 'icons/turf/floor/sidewalk.dmi'
	icon_state = "1"

	footstep = /footstep/concrete

	map_color = COLOR_GREY

/turf/simulated/floor/sidewalk/New(var/desired_loc)
	icon_state = "[rand(1,6)]"
	. = ..()

/turf/simulated/floor/sidewalk/update_overlays()

	. = ..()

	var/desired_shade_direction = 0x0

	for(var/k in DIRECTIONS_CARDINAL)
		var/turf/T = get_step(src,k)
		if(!T || T.type != src.type)
			continue
		desired_shade_direction |= k

	if((desired_shade_direction & NORTH) && (desired_shade_direction & SOUTH))
		desired_shade_direction &= ~NORTH

	if((desired_shade_direction & EAST) && (desired_shade_direction & WEST))
		desired_shade_direction &= ~EAST

	if(desired_shade_direction)
		var/image/I = new/image(initial(icon),"shading")
		add_overlay(I)

	src.dir = desired_shade_direction

	name = "[dir2text(desired_shade_direction)]"