/turf/simulated/floor/colored/sand
	name = "grey sand"
	color = "#80806D"
	layer = LAYER_FLOOR_SAND //LAYER_FLOOR + 0.14
	corner_category = "sand"

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"

	footstep = /footstep/asteroid

	move_delay_modifier = 1.1

	material_id = /material/dirt/

	destruction_turf = /turf/simulated/floor/colored/dirt //TODO: Change to sandstone.

/turf/simulated/floor/colored/sand/oasis
	name = "sand"
	color = "#CCBC8A"
	layer = LAYER_FLOOR + 0.141 //can't +n LAYER_FLOOR_[whatever] for some reason

/turf/simulated/floor/colored/sand/beach
	name = "beach sand"
	color = "#DED1BD"
	layer = LAYER_FLOOR + 0.141

/turf/simulated/floor/colored/sand/underwater
	name = "bed sand"
	color = "#AECA91"
	layer = LAYER_FLOOR + 0.141

/turf/simulated/floor/colored/sand/desert
	name = "sand"
	//color = "#FFC68C"
	color = "#AE8A67"
	layer = LAYER_FLOOR + 0.141