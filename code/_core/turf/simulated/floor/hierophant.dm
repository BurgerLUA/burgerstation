/turf/simulated/floor/hierophant
	name = "hierophant floor"

	icon = 'icons/turf/floor/hierophant.dmi'
	icon_state = "floor1"

	layer = LAYER_FLOOR_TILE

	footstep = /footstep/concrete

/turf/simulated/floor/hierophant/New(var/desired_loc)

	if((x+y) % 2)
		desired_light_frequency = 1
		desired_light_power = 0.5
		desired_light_range = 8
		desired_light_color = "#FF00DC"
		map_color = "#FF00DC"
		icon_state = "floor1"
		//move_delay_modifier = 0.5
	else
		icon_state = "floor2"
		//move_delay_modifier = 2