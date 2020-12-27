/obj/structure/interactive/lighting/fixture/tube
	name = "tube light"
	desc = "An electrical storm has been detected in proximity of the station. Please check all equipment for potential overloads."
	desc_extended = "Used to light up the area."

	icon = 'icons/obj/structure/light_tube.dmi'

	desired_light_power = 0.5
	desired_light_range = 7
	desired_light_color = null //Set in update_icon
	desired_light_angle = LIGHT_TUBE

/obj/structure/interactive/lighting/fixture/tube/New() //SETUP_DIR_OFFSETS

	. = ..()

	switch(dir)
		if(NORTH)
			pixel_y = -2
		if(SOUTH)
			pixel_y = 2
		if(EAST)
			pixel_x = -2
		if(WEST)
			pixel_x = 2

	return .


/obj/structure/interactive/lighting/fixture/tube/color
	name = "colored light"
	color = "#FFFFFF"

	desired_light_power = 1
	desired_light_range = 3

/obj/structure/interactive/lighting/fixture/tube/color/turf/Initialize()
	if(loc)
		color = loc.color
		name = loc.color
	return ..()

/obj/structure/interactive/lighting/fixture/tube/syndicate
	color = "#FFBABA"
	color_frame = "#666666"
	desired_light_power = 0.5
	desired_light_range = VIEW_RANGE*0.6

/obj/structure/interactive/lighting/fixture/tube/station
	color = COLOR_LIGHT
	color_frame = COLOR_GREY
	desired_light_power = 0.75
	desired_light_range = VIEW_RANGE*0.6

/obj/structure/interactive/lighting/fixture/tube/station/strong
	desired_light_power = 0.80
	desired_light_range = VIEW_RANGE*0.7

/obj/structure/interactive/lighting/fixture/tube/station/stronger
	desired_light_power = 0.85
	desired_light_range = VIEW_RANGE*0.8