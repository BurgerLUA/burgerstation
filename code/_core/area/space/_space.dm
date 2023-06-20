/area/space
	name = "space"
	icon_state = "spess"
	ambient_temperature = 20 //Darkness of interstellar space is 3 kelvin. Setting to 20k because there are some small stars.

	ambient_sound = 'sound/ambient/cave_2.ogg'

	sunlight_freq = 10
	sunlight_color = "#F8FFFF"

	area_identifier = null

	flags_area = FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS | FLAG_AREA_NO_TELEPORT

	sound_environment = ENVIRONMENT_UNDERWATER

	dynamic_lighting = FALSE

/area/space/is_space()
	return TRUE

/area/space/bluespace
	name = "bluespace light"
	icon_state=  "bluespess"

	sunlight_color = null
	sunlight_freq = 0

	cheese_type = /reagent/nutrition/cheese/bluespace

/area/space/deep
	name = "deep space"
	icon_state = "deepspess"

	sunlight_color = null
	sunlight_freq = 0

/area/space/light
	icon_state = "spess_light"
	sunlight_freq = 3