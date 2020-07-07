/area/space
	name = "space"
	icon_state = "spess"
	ambient_temperature = 20 //Darkness of interstellar space is 3 kelvin. Setting to 20k because there are some small stars.

	ambient_sound = 'sound/ambient/cave_2.ogg'

	sunlight_freq = 4
	sunlight_color = "#1A3E4C"

/area/space/bluespace
	name = "bluespace"
	icon_state=  "bluespess"

	sunlight_freq = 8
	sunlight_color = "#0094FF"

	cheese_type = /reagent/nutrition/cheese/bluespace

/area/space/deep
	name = "deep space"
	icon_state = "deepspess"

	sunlight_freq = 0

/area/space/light
	icon_state = "spess_light"
	sunlight_freq = 1