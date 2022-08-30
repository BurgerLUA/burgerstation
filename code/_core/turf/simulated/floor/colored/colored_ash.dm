/turf/simulated/floor/colored/ash/
	name = "ash"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "ash"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"
	corner_icons = TRUE
	corner_category = "ash"

	footstep = /footstep/asteroid

	move_delay_modifier = 1.1

	layer = LAYER_FLOOR_WEATHER + 0.1

	material_id = /material/dirt/

	destruction_turf = /turf/simulated/floor/basalt/

/turf/simulated/floor/colored/ash/necro
	name = "necro ash"
	color = "#211811"
	corner_category = "ash_necro"
	layer = LAYER_FLOOR_WEATHER + 0.2

/turf/simulated/floor/colored/ash/dark
	name = "volcanic ash"
	color = "#545454"
	corner_category = "ash_volcanic"
	layer = LAYER_FLOOR_WEATHER + 0.3

/turf/simulated/floor/colored/ash/rocky
	name = "rocky ash"
	color = "#563F2D"
	icon_state = "ash_rocky"
	corner_category = "ash_rocky"

	real_icon = 'icons/turf/floor/rocky_ash.dmi'

	layer = LAYER_FLOOR_WEATHER + 0
