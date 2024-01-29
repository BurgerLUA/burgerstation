/turf/simulated/floor/basalt/
	name = "basalt"

	icon = 'icons/turf/floor/basalt.dmi'
	icon_state = "basalt0"

	real_icon = 'icons/turf/floor/basalt_smooth.dmi'
	real_icon_state = "floor"

	corner_icons = TRUE
	corner_category = "basalt"

	layer = LAYER_FLOOR_ROCK

	footstep = /footstep/concrete

	move_delay_modifier = 1.05

	destruction_turf = /turf/simulated/liquid/lava/

	health_base = 300

	organic = TRUE

	map_color = COLOR_GREY_DARK

	var/light_turf = FALSE

/turf/simulated/floor/basalt/setup_turf_light(sunlight_freq)
	if(light_turf) src.set_light(4,0.5,"#FF8300")
	return TRUE

/turf/simulated/floor/basalt/update_icon()

	. = ..()

	if(smooth_code_1 == "f" && smooth_code_2 == "f" && smooth_code_3 == "f" && smooth_code_4 == "f")
		icon = initial(icon)
		if(prob(3))
			light_turf = TRUE
			icon_state = "basalt[rand(1,5)]"
		else if(prob(6))
			icon_state = "basalt[rand(6,12)]"
		else
			icon_state = "basalt0"
		pixel_x = 0
		pixel_y = 0

/turf/simulated/floor/basalt/Finalize()
	. = ..()
	if(!light_turf && prob(2))
		if(!SSturf.initialized)
			var/obj/structure/interactive/basalt/B = new(src)
			B.pixel_x = rand(-5,5)
			B.pixel_y = rand(-5,5)