/turf/simulated/space
	name = "space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "preview"
	opacity = 0
	plane = PLANE_SPACE
	dynamic_lighting = TRUE

/turf/simulated/space/New(var/desired_loc)
	. = ..()
	icon = null
	icon_state = null
	invisibility = 101

/turf/simulated/space/is_space()
	return TRUE