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

	delay_modifier = 1.05

	destruction_turf = /turf/simulated/hazard/lava/

/turf/simulated/floor/basalt/setup_turf_light(var/sunlight_freq)
	if(prob(10))
		icon_state = "basalt[rand(1,4)]"
		src.set_light(4,0.5,"#FF8300")
	else if(prob(20))
		icon_state = "basalt[rand(4,12)]"
	return TRUE
