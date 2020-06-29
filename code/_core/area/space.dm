/area/space
	name = "space"
	icon_state = "spess"
	ambient_temperature = 20 //Darkness of interstellar space is 3 kelvin. Setting to 20k because there are some small stars.

	ambient_sound = 'sound/ambient/cave_2.ogg'

	sunlight_freq = 4

	desired_light_range = 5
	desired_light_power = 1
	desired_light_color = "#1A3E4C"

	is_space = TRUE

/area/space/bluespace
	name = "bluespace"
	icon_state=  "bluespess"

	sunlight_freq = 8
	desired_light_range = 9
	desired_light_power = 1
	desired_light_color = "#0094FF"

	cheese_type = /reagent/nutrition/cheese/bluespace

/area/space/deep
	name = "deep space"
	icon_state = "deepspess"

	sunlight_freq = 0

	desired_light_range = 0
	desired_light_power = 0
	desired_light_color = 0


/area/space/light
	icon_state = "spess_light"
	sunlight_freq = 1