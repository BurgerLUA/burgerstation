/turf/simulated/floor/hierophant
	name = "hierophant floor"

	icon = 'icons/turf/floor/hierophant.dmi'
	icon_state = "floor1"

	layer = LAYER_FLOOR_TILE

	footstep = /footstep/concrete

/turf/simulated/floor/hierophant/New(var/desired_loc)

	. = ..()

	if((x+y) % 2)
		icon_state = "floor2"
	else
		desired_light_frequency = 1
		desired_light_power = 0.25
		desired_light_range = 2
		desired_light_color = "#FF00DC"
		map_color = "#FF00DC"
		icon_state = "floor3"
