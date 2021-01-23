/turf/simulated/floor/grass/
	name = " dense grass"
	desc = "Some grass on the ground"
	desc_extended = "Damn daniel back at it agian with the green grass"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "grass_new"

	real_icon = 'icons/turf/floor/grass_new.dmi'
	real_icon_state = "floor"
	corner_icons = TRUE

	footstep = /footstep/grass

	destruction_turf = /turf/simulated/floor/colored/grass

	layer = LAYER_FLOOR_GRASS

	corner_category = "dense_grass"

	material_id = /material/grass/

/turf/simulated/floor/grass/jungle
	name = "dense jungle grass"
	color = "#969696"
	destruction_turf = /turf/simulated/floor/colored/grass/jungle
	desc = "Some junglely grass"
	desc_extended = "unlike what some people believe, jungle grass isn't just grass that likes to listen to jungle music"

/*
/turf/simulated/floor/grass/smooth_turfs()

	var/list/smooth_code = get_smooth_code()

	var/ne = smooth_code[1]
	var/nw = smooth_code[2]
	var/se = smooth_code[3]
	var/sw = smooth_code[4]

	if("[ne][nw][se][sw]" != "iiii")
		return ..()

	icon = real_icon
	icon_state = "grass[rand(0,3)]"
	pixel_x = (32 - 48)/2
	pixel_y = (32 - 48)/2
	layer = initial(layer) + 0.1

	return TRUE
*/
