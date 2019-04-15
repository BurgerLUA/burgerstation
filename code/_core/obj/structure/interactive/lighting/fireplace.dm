/obj/structure/interactive/lighting/fireplace
	name = "fireplace"
	desc = "a large fireplace"

	density = 0
	opacity = 0

	icon = 'icons/obj/structure/modern/fireplace.dmi'
	icon_state = "fireplace"

	light_power = 0.5
	light_range = 1
	light_color = "#FFFFB5"

/obj/structure/interactive/lighting/fireplace/New()
	..()
	update_icon()

/obj/structure/interactive/lighting/fireplace/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(light_range <= 0)
		return ..()

	var/light_mod = clamp(round(light_range-1),0,4)
	var/icon/I = new/icon(icon,icon_state)
	var/icon/F = new/icon(icon,"fireplace_fire[light_mod]")

	I.Blend(F,ICON_OVERLAY)

	if(light_mod > 0)
		var/icon/F2 = new/icon(icon,"fireplace_glow")
		I.Blend(F2,ICON_OVERLAY)

	icon = I

/obj/structure/interactive/lighting/fireplace/fire01
	light_range = 1

/obj/structure/interactive/lighting/fireplace/fire02
	light_range = 2

/obj/structure/interactive/lighting/fireplace/fire03
	light_range = 3

/obj/structure/interactive/lighting/fireplace/fire04
	light_range = 4

/obj/structure/interactive/lighting/fireplace/fire05
	light_range = 5
