/obj/structure/interactive/lighting/tube
	name = "tube light"

	icon = 'icons/obj/structure/lights.dmi'
	icon_state = "tube"

	desired_light_power = 0.4
	desired_light_range = 6
	desired_light_color = "#FFFFAA"

	layer = LAYER_LARGE_OBJ
	plane = PLANE_WALL_ATTACHMENTS

/obj/structure/interactive/lighting/tube/off
	desired_light_power = 0
	desired_light_range = 0
	desired_light_color = "#FFFFFF"

/obj/structure/interactive/lighting/tube/off/update_icon()
	return

/obj/structure/interactive/lighting/tube/New()
	..()
	update_icon()

/obj/structure/interactive/lighting/tube/update_icon()

	icon = initial(icon)

	var/icon/I = new /icon(icon,icon_state)
	var/icon/O = new /icon(icon,icon_state + "_overlay")

	I.Blend(O,ICON_OVERLAY)

	icon = I


/obj/structure/interactive/lighting/tube/strong
	desired_light_power = 0.4
	desired_light_range = 8

/obj/structure/interactive/lighting/tube/stronger
	desired_light_power = 0.8
	desired_light_range = 4
