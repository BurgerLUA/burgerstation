
/turf/simulated/floor/grass
	name = "grass"
	icon = 'icons/turf/floor/natural.dmi'
	icon_state = "grass"

	footstep_id = "grass"


/turf/simulated/floor/grass/New()
	var/lightness = 255 - (x + y)*0.5
	lightness += rand(-5,0)
	color = rgb(lightness,lightness,lightness)
	..()
