/obj/structure/interactive/lighting/fireplace
	name = "fireplace"
	desc = "a large fireplace"

	opacity = 0

	icon = 'icons/obj/structure/fireplace.dmi'
	icon_state = "fireplace"

	desired_light_power = 0.8
	desired_light_range = 2
	desired_light_color = "#FFFFB5"

	plane = PLANE_WALL_ATTACHMENT

/obj/structure/interactive/lighting/fireplace/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/lighting/fireplace/update_overlays()
	. = ..()

	if(desired_light_range > 0)
		var/light_mod = min(CEILING(desired_light_range/2,1),4)
		var/image/G = new/image(initial(icon),"fireplace_glow")
		add_overlay(G)
		var/image/L = new/image(initial(icon),"fireplace_fire[light_mod]")
		add_overlay(L)

/obj/structure/interactive/lighting/fireplace/fire01
	desired_light_range = 2

/obj/structure/interactive/lighting/fireplace/fire02
	desired_light_range = 4

/obj/structure/interactive/lighting/fireplace/fire03
	desired_light_range = 6

/obj/structure/interactive/lighting/fireplace/fire04
	desired_light_range = 8
