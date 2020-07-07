/obj/structure/interactive/lighting/floor
	name = "tube light"
	desc = "An electrical storm has been detected in proximity of the station. Please check all equipment for potential overloads."
	desc_extended = "Used to light up the area."

	icon = 'icons/obj/structure/lights_new.dmi'
	icon_state = "floor_light"

	desired_light_power = 0.25
	desired_light_range = 7
	desired_light_color = null //Set in update_icon

	layer = LAYER_OBJ
	plane = PLANE_OBJ

	var/on = TRUE

	color = "#FFFFAA"
	var/color_frame = "#888888"



/obj/structure/interactive/lighting/floor/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/lighting/floor/update_icon()

	if(color)
		desired_light_color = color
	else
		desired_light_color = "#FFFFFF"

	if(desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color)

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new /icon(icon,"floor")

	var/icon/F = new /icon(icon,"floor_bulb")
	F.Blend(color_frame,ICON_MULTIPLY)
	I.Blend(F,ICON_OVERLAY)

	if(on)
		var/icon/L = new /icon(icon,"floor_light")
		L.Blend(desired_light_color,ICON_MULTIPLY)
		I.Blend(L,ICON_OVERLAY)

	icon = I

/obj/structure/interactive/lighting/floor/strong
	desired_light_power = 0.4
	desired_light_range = 8

/obj/structure/interactive/lighting/floor/stronger
	desired_light_power = 0.5
	desired_light_range = 16


/obj/structure/interactive/lighting/floor/color
	name = "colored light"
	color = "#FFFFFF"

	desired_light_power = 1
	desired_light_range = 3


/obj/structure/interactive/lighting/floor/color/turf/Initialize()

	if(loc)
		color = loc.color
		name = loc.color

	return ..()

/obj/structure/interactive/lighting/floor/syndicate
	color = "#FFBABA"
	color_frame = "#666666"