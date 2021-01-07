/turf/simulated/floor/plating
	name = "plating"

	icon = 'icons/turf/floor/plating.dmi'
	icon_state = "empty"

	footstep = /footstep/plating

	color = COLOR_STEEL
	material_id = /material/steel

	layer = LAYER_FLOOR_PLATING

	exposed = TRUE
	desc = "The plating underneath the floor"
	desc_extended = "A floor found underneath an actual floor."

/turf/simulated/floor/plating/snow
	name = "snowed plating"
	icon = 'icons/turf/floor/plating.dmi'
	icon_state = "empty"

/turf/simulated/floor/plating/shuttle
	name = "reinforced plating"
	icon = 'icons/turf/floor/shuttle.dmi'
	icon_state = "plating"
	plane = PLANE_SHUTTLE
