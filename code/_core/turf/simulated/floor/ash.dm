/turf/simulated/floor/colored/ash/
	name = "ash"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "ash"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"
	corner_icons = TRUE
	corner_category = "ash"

	footstep = /footstep/asteroid

	delay_modifier = 1.1

	layer = LAYER_FLOOR_WEATHER

	material_id = /material/dirt/

	destruction_turf = /turf/simulated/floor/basalt/

/turf/simulated/floor/colored/ash/grey
	name = "ancient ash"
	color = "#5E5D77"

/turf/simulated/floor/colored/ash/necro
	name = "necro ash"
	color = "#211811"

/turf/simulated/floor/colored/ash/dark
	name = "volcanic ash"
	color = "#3F3F3F"

/turf/simulated/floor/colored/ash/rocky
	name = "rocky ash"
	color = "#563F2D"
	icon_state = "ash_rocky"

	real_icon = 'icons/turf/floor/rocky_ash.dmi'
