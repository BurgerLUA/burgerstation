/turf/simulated/floor/grass
	name = "grass"
	icon = 'icons/turf/floor/natural.dmi'
	icon_state = "grass"

	footstep_sounds = list(
		'sounds/effects/footsteps/grass1.ogg',
		'sounds/effects/footsteps/grass2.ogg',
		'sounds/effects/footsteps/grass3.ogg',
		'sounds/effects/footsteps/grass4.ogg'
	)


/turf/simulated/floor/grass/New()
	var/lightness = 255 - (x + y)*0.5
	lightness += rand(-5,0)
	color = rgb(lightness,lightness,lightness)
	..()
