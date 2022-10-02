/turf/simulated/wall/hierophant
	name = "hierophant wall"
	desc = "Very purple"
	desc_extended = "a wall made of an unknown metal, there are rippling patterns of purple light across it."
	icon = 'icons/turf/wall/hierophant.dmi'
	icon_state = "wall"
	corner_icons = TRUE
	corner_category = "hierophant"

	desired_light_frequency = 1
	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#AA00DC"
	map_color = "#AA00DC"

/turf/simulated/wall/hierophant/Finalize()
	. = ..()
	src.set_light(4,0.25,"#FFFFFF")