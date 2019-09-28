/turf/simulated/floor/lava/
	name = "lava"
	icon = 'icons/turf/floor/lava.dmi'
	icon_state = "floor"
	corner_icons = TRUE
	corner_category = "lava"

	light_power = DEFAULT_BRIGHTNESS_AMBIENT * 0.5
	light_range = 6
	light_color = "#FF8300"

/turf/simulated/floor/lava/New(var/desired_loc)
	. = ..()
	set_light(light_range,light_power,light_color)
	return .