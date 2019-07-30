/turf/simulated/floor/basalt/
	name = "basalt"
	icon = 'icons/turf/floor/basalt.dmi'
	icon_state = "basalt1"
	light_color = "#FFFFFF"

/turf/simulated/floor/basalt/New(var/desired_loc)
	if(prob(10))
		icon_state = "basalt[rand(2,4)]"
		light_range = 2
		light_color = "#FF8300"

	. = ..()