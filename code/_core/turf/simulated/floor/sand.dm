/turf/simulated/floor/sand
	name = "sand"
	icon = 'icons/turf/floor/natural.dmi'
	icon_state = "sand01"

	footstep_sounds = list(
		'sounds/effects/footsteps/grass1.ogg',
		'sounds/effects/footsteps/grass2.ogg',
		'sounds/effects/footsteps/grass3.ogg',
		'sounds/effects/footsteps/grass4.ogg'
	)

/turf/simulated/floor/sand/New(var/desired_loc)
	icon_state = "sand0[rand(1,4)]"
	. = ..()