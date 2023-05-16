/turf/simulated/floor/colored/ash/
	name = "ash floor"

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

	health_base = 200

/turf/simulated/floor/colored/ash/necro
	name = "necro ash"
	color = "#211811"
	corner_category = "ash_necro"
	layer = LAYER_FLOOR_WEATHER + 0.2

/turf/simulated/floor/colored/ash/volcanic
	name = "volcanic ash floor"
	color = "#544842"
	corner_category = "ash_volcanic"
	layer = LAYER_FLOOR_WEATHER + 0.3

	destruction_turf = /turf/simulated/floor/basalt