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

	health_base = 100

/turf/simulated/floor/colored/sand/beach
	name = "beach sand"
	color = "#DED1BD"
	layer = LAYER_FLOOR + 0.142
	corner_category = "sand_beach"

/turf/simulated/floor/colored/sand/beach/shallow
	name = "shallow beach"
	color = "#C6D1BD"
	layer = LAYER_FLOOR + 0.141
	corner_category = "sand_beach_shallow"

/turf/simulated/floor/colored/sand/underwater
	name = "bed sand"
	color = "#AECA91"
	layer = LAYER_FLOOR + 0.140
	corner_category = "sand_underwater"

/turf/simulated/floor/colored/sand/desert
	name = "sand"
	//color = "#FFC68C"
	color = "#AE8A67"
	layer = LAYER_FLOOR + 0.144
	corner_category = "sand_desert"

/turf/simulated/floor/colored/sand/desert/lighter
	corner_category = "sand_desert_lighter"
	color = "#CCBC8A"

/turf/simulated/floor/colored/sand/desert/gabber
	destruction_turf = /turf/simulated/floor/plating/reinforced