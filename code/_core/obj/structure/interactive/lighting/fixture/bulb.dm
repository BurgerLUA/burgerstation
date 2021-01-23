/obj/structure/interactive/lighting/fixture/bulb
	name = "tube light"
	desc = "An electrical storm has been detected in proximity of the station. Please check all equipment for potential overloads."
	desc_extended = "Used to light up the area."

	icon = 'icons/obj/structure/light_bulb.dmi'

	desired_light_power = 0.5
	desired_light_range = 5
	desired_light_color = null //Set in update_icon
	desired_light_angle = LIGHT_OMNI

/obj/structure/interactive/lighting/fixture/bulb/New()

	. = ..()

	switch(dir)
		if(NORTH)
			pixel_y = 1
		if(SOUTH)
			pixel_y = -1
		if(EAST)
			pixel_x = 1
		if(WEST)
			pixel_x = -1

	return .