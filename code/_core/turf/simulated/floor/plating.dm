/turf/simulated/floor/plating
	name = "steel floor plating"

	icon = 'icons/turf/floor/plating.dmi'
	icon_state = "empty"

	footstep = /footstep/plating

	color = COLOR_STEEL
	material_id = /material/steel

	layer = LAYER_FLOOR_PLATING

	exposed = TRUE
	desc = "The plating underneath the floor"
	desc_extended = "A floor found underneath an actual floor."

/turf/simulated/floor/plating/reinforced
	name = "reinforced plating"
	icon_state = "filled3"
	exposed = FALSE

/turf/simulated/floor/plating/New(var/desired_loc)
	. = ..()
	map_color = color

/turf/simulated/floor/plating/snow
	name = "snowed plating"
	icon = 'icons/turf/floor/plating.dmi'
	icon_state = "empty"

/turf/simulated/floor/plating/shuttle
	name = "reinforced plating"
	icon = 'icons/turf/floor/spaceship.dmi'
	icon_state = "plating"
	plane = PLANE_SHUTTLE


/turf/simulated/floor/plating/syndicate
	name = "dark steel floor plating"
	color = COLOR_STEEL_DARK

/turf/simulated/floor/plating/rev
	name = "tinted steel floor plating"
	color = "#626A3B"