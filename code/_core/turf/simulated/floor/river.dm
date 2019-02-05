/turf/simulated/floor/river
	name = "passible river"
	desc = "About a 6 out of 10."
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater"

/turf/simulated/floor/river/New()
	var/lightness = 255 - x*0.25
	color = rgb(lightness,lightness,lightness)
	..()