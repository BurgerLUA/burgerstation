/turf/simulated/floor/asteroid
	name = "sand"
	icon = 'icons/turf/floor/natural.dmi'
	icon_state = "asteroid0"

	footstep_sounds = list(
		'sounds/effects/footsteps/asteroid1.ogg',
		'sounds/effects/footsteps/asteroid2.ogg',
		'sounds/effects/footsteps/asteroid3.ogg',
		'sounds/effects/footsteps/asteroid4.ogg',
		'sounds/effects/footsteps/asteroid5.ogg'
	)

/turf/simulated/floor/asteroid/New(var/desired_loc)

	if(prob(25))
		icon_state = "asteroid[rand(1,12)]"

	return ..()