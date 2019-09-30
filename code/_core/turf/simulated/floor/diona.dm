/turf/simulated/floor/diona
	name = "biomass floor"
	icon = 'icons/turf/floor/diona.dmi'
	icon_state = "1"

	desired_light_power = DEFAULT_BRIGHTNESS_AMBIENT_STRONG
	desired_light_range = 2
	desired_light_color = "#9FD733"

/turf/simulated/floor/diona/New()
	icon_state = "[rand(1,4)]"
	..()
