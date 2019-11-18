/obj/structure/interactive/lighting/tube
	name = "tube light"

	icon = 'icons/obj/structure/lights_new.dmi'
	icon_state = "tube_light"

	desired_light_power = 0.4
	desired_light_range = 6
	desired_light_color = null //Set in update_icon

	layer = LAYER_LARGE_OBJ
	plane = PLANE_WALL_ATTACHMENTS

	var/on = TRUE

	color = "#FFFFAA"
	var/color_frame = "#888888"

/obj/structure/interactive/lighting/tube/New()

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

/obj/structure/interactive/lighting/tube/Initialize()
	. = ..()
	update_icon()
	return .

/obj/structure/interactive/lighting/tube/update_icon()

	if(color)
		desired_light_color = color
	else
		desired_light_color = "#FFFFFF"

	if(desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color)

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new /icon(icon,"tube")

	var/icon/F = new /icon(icon,"tube_frame")
	F.Blend(color_frame,ICON_MULTIPLY)
	I.Blend(F,ICON_OVERLAY)

	if(on)
		var/icon/L = new /icon(icon,"tube_light")
		L.Blend(desired_light_color,ICON_MULTIPLY)
		I.Blend(L,ICON_OVERLAY)

	icon = I

/obj/structure/interactive/lighting/tube/strong
	desired_light_power = 0.4
	desired_light_range = 8

/obj/structure/interactive/lighting/tube/stronger
	desired_light_power = 0.8
	desired_light_range = 4


/obj/structure/interactive/lighting/tube/color
	name = "colored light"
	color = "#FFFFFF"

	desired_light_power = 1
	desired_light_range = 3


/obj/structure/interactive/lighting/tube/color/turf/Initialize()

	if(loc)
		color = loc.color
		name = loc.color

	return ..()
