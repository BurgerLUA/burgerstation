/obj/structure/interactive/lighting/streetlamp
	name = "street lamp"

	icon = 'icons/obj/structure/light_large.dmi'
	icon_state = "streetlamp"

	desired_light_power = 0.5
	desired_light_range = 4
	desired_light_color = "#FFFFB5"

	layer = LAYER_ABOVE_MOB

	plane = PLANE_MOB

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

/obj/structure/interactive/lighting/streetlamp/strong
	desired_light_power = 0.4
	desired_light_range = 8

/obj/structure/interactive/lighting/streetlamp/snow
	icon_state = "streetlamp_snow"

/obj/structure/interactive/lighting/streetlamp/jungle
	icon_state = "torch"

/obj/structure/interactive/lighting/streetlamp/jungle/dark
	icon_state = "torch_dark"



