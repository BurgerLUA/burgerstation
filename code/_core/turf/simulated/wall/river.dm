/turf/simulated/wall/river
	name = "impassible river"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater"
	opacity = 0
	allow_bullet_pass = TRUE
	layer = LAYER_FLOOR

	light_power = DEFAULT_BRIGHTNESS_TURF_LIGHT_HIGH
	light_range = 2
	light_color = "#AAAAFF"

/turf/simulated/wall/river/non_moving
	icon_state = "riverwater_static"

/turf/simulated/wall/river/New()
	var/lightness = 255 - x*0.25
	color = rgb(lightness,lightness,lightness)
	..()