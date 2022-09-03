/obj/structure/interactive/lighting/fixture/bulb
	name = "tube light"
	desc = "An electrical storm has been detected in proximity of the station. Please check all equipment for potential overloads."
	desc_extended = "Used to light up the area."

	icon = 'icons/obj/structure/light_bulb.dmi'

	color = COLOR_LIGHT_BULB

	desired_light_power = 0.5
	desired_light_range = 5
	desired_light_color = null //Set in update_icon
	desired_light_angle = LIGHT_OMNI

	dir_offset = 2


/obj/structure/interactive/lighting/fixture/bulb/green
	color = COLOR_GREEN_LIGHT