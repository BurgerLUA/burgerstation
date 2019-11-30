/turf/simulated/floor/asteroid
	name = "sand"
	icon = 'icons/turf/floor/natural.dmi'
	icon_state = "asteroid0"

	footstep_id = "asteroid"

/turf/simulated/floor/asteroid/New(var/desired_loc)

	if(prob(25))
		icon_state = "asteroid[rand(1,12)]"

	return ..()