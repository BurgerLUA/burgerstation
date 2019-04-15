/turf/simulated/floor/basalt/
	name = "basalt"
	icon = 'icons/turf/floor/basalt.dmi'
	icon_state = "basalt1"

	light_power = DEFAULT_BRIGHTNESS_EXTERIOR
	light_range = 2
	light_color = "#FF8300"


/turf/simulated/floor/basalt/New(var/desired_loc)
	if(prob(y))
		icon_state = "basalt[rand(2,4)]"

	. = ..()