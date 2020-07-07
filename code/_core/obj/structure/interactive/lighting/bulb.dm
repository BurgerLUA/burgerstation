/obj/structure/interactive/lighting/bulb
	name = "bulb light"

	icon = 'icons/obj/structure/lights_new.dmi'
	icon_state = "bulb_light"

	desired_light_power = 0.4
	desired_light_range = 4
	desired_light_color = null //Set in update_icon

	layer = LAYER_LARGE_OBJ
	plane = PLANE_WALL_ATTACHMENTS

	var/on = TRUE

	color = COLOR_LIGHT
	var/color_frame = "#888888"

	rotation_mod = -1

/obj/structure/interactive/lighting/bulb/New()

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

/obj/structure/interactive/lighting/bulb/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/lighting/bulb/update_icon()

	if(color)
		desired_light_color = color
	else
		desired_light_color = "#FFFFFF"

	if(desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color)

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new /icon(icon,"bulb")

	var/icon/F = new /icon(icon,"bulb_bulb")
	F.Blend(color_frame,ICON_MULTIPLY)
	I.Blend(F,ICON_OVERLAY)

	if(on)
		var/icon/L = new /icon(icon,"bulb_light")
		L.Blend(desired_light_color,ICON_MULTIPLY)
		I.Blend(L,ICON_OVERLAY)

	icon = I