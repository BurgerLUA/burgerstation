/turf/simulated/wall/river
	name = "impassible river"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater"
	opacity = 0

/turf/simulated/wall/river/New()
	var/lightness = 255 - x*0.25
	color = rgb(lightness,lightness,lightness)
	..()