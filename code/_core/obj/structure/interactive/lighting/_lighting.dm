/obj/structure/interactive/lighting/



/obj/structure/interactive/lighting/New(var/desired_loc)

	. = ..()

	if(desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color)

	return .



