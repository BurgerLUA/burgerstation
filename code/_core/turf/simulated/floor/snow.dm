/turf/simulated/floor/snow
	name = "snow"
	icon = 'icons/turf/floor/ice.dmi'
	icon_state = "snow"

	footstep_sounds = list(
		'sounds/effects/footsteps/grass1.ogg',
		'sounds/effects/footsteps/grass2.ogg',
		'sounds/effects/footsteps/grass3.ogg',
		'sounds/effects/footsteps/grass4.ogg'
	)

/turf/simulated/floor/snow/New()
	icon_state = "snow[rand(0,12)]"
	var/lightness = 255 - (x + y)*0.25
	lightness += rand(-5,0)
	color = rgb(lightness,lightness,lightness)
	..()

/turf/simulated/floor/ice
	name = "ice"
	icon = 'icons/turf/floor/ice.dmi'
	icon_state = "floor"

	footstep_sounds = list(
		'sounds/effects/footsteps/grass1.ogg',
		'sounds/effects/footsteps/grass2.ogg',
		'sounds/effects/footsteps/grass3.ogg',
		'sounds/effects/footsteps/grass4.ogg'
	)

	corner_icons = TRUE
	corner_category = "ice"

/turf/simulated/floor/snow_plating
	name = "plating"
	icon = 'icons/turf/floor/snow_plating.dmi'
	icon_state = "floor"

	footstep_sounds = list(
		'sounds/effects/footsteps/grass1.ogg',
		'sounds/effects/footsteps/grass2.ogg',
		'sounds/effects/footsteps/grass3.ogg',
		'sounds/effects/footsteps/grass4.ogg'
	)

	corner_icons = TRUE
	corner_category = "snow_plating"