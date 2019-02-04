/turf/simulated/floor/basalt/
	name = "basalt"
	icon = 'icons/turf/floor/basalt.dmi'
	icon_state = "basalt1"

/turf/simulated/floor/basalt/New(var/desired_loc)
	icon_state = "basalt[rand(1,4)]"
	. = ..()