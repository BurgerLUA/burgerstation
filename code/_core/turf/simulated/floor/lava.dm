/turf/simulated/floor/lava/
	name = "lava"
	icon = 'icons/turf/floor/lava.dmi'
	icon_state = "floor"
	corner_icons = TRUE
	corner_category = "lava"

	desired_light_power = DEFAULT_BRIGHTNESS_AMBIENT * 0.5
	desired_light_range = 6
	desired_light_color = "#FF8300"

/turf/simulated/floor/lava/New(var/desired_loc)
	. = ..()
	set_light(desired_light_range,desired_light_power,desired_light_color)
	return .