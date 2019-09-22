/obj/structure/interactive/lighting/tube
	name = "tube light"

	icon = 'icons/obj/structure/lights.dmi'
	icon_state = "tube"

	light_power = 0.25
	light_range = 4
	light_color = "#FFFFAA"

	layer = LAYER_LARGE_OBJ

/obj/structure/interactive/lighting/tube/off
	light_power = 0
	light_range = 0
	light_color = "#FFFFFF"

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
	light_power = 0.4
	light_range = 6
	light_color = "#FFFFAA"
