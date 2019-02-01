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
	icon_state = "asteroid[rand(0,12)]"
	var/lightness = 255 - (x + y)*0.25
	lightness += rand(-1,1)
	color = rgb(lightness,lightness,lightness)
	..()