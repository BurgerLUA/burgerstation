/turf/simulated/floor/river
	name = "river"
	desc = "About a 6 out of 10."
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater_static"

	collision_flags = FLAG_COLLISION_WALKING

	light_power = DEFAULT_BRIGHTNESS_AMBIENT
	light_range = DEFAULT_RANGE_AMBIENT
	light_color = "#AAAAFF"

/turf/simulated/floor/river/walkable
	collision_flags = FLAG_COLLISION_NONE

/*
/turf/simulated/floor/river/New()
	var/lightness = 255 - x*0.25
	color = rgb(lightness,lightness,lightness)
	..()
*/