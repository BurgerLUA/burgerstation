/turf/simulated/floor/river
	name = "river"
	desc = "About a 6 out of 10."
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater"

	collision_flags = FLAG_COLLISION_WALKING


/turf/simulated/floor/river/walkable
	collision_flags = FLAG_COLLISION_NONE

/*
/turf/simulated/floor/river/New()
	var/lightness = 255 - x*0.25
	color = rgb(lightness,lightness,lightness)
	..()
*/