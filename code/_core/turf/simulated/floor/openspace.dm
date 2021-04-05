/atom/movable/openspace_backdrop
	icon = 'icons/turf/floor/openspace.dmi'
	icon_state = "openspace_background"
	anchored = TRUE

/turf/simulated/openspace
	name = "hole"
	desc = "Down the rabbit hole you go!"
	desc_extended = "A hole that leads to a lower level, be careful as they can hurt."
	icon = 'icons/turf/floor/openspace.dmi'
	icon_state = "openspace_background"

	destruction_turf = null
	health = null

	density = TRUE
	density_down = FALSE

	plane = PLANE_FLOOR_BELOW

/turf/simulated/openspace/Initialize()
	. = ..()
	var/turf/T = locate(x,y,z-1)
	if(T) vis_contents += T