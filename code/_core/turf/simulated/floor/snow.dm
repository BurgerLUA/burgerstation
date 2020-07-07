/turf/simulated/floor/snow
	name = "snow"
	icon = 'icons/turf/floor/ice.dmi'
	icon_state = "snow"

	footstep = /footstep/snow

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

	corner_icons = TRUE
	corner_category = "ice"

/turf/simulated/floor/snow_plating
	name = "plating"
	icon = 'icons/turf/floor/snow_plating.dmi'
	icon_state = "floor"

	corner_icons = TRUE
	corner_category = "snow_plating"