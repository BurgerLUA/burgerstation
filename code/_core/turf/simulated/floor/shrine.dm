/turf/simulated/floor/shrine
	name = "ancient shrine floor"
	icon = 'icons/turf/floor/shrine.dmi'
	icon_state = "0"


/turf/simulated/floor/shrine/New(desired_loc)
	. = ..()
	if(prob(25))
		icon_state = "[rand(1,4)]"