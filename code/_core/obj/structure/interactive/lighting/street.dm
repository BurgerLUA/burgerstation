/obj/structure/interactive/lighting/streetlamp
	name = "street lamp"

	icon = 'icons/obj/structure/light_large.dmi'
	icon_state = "streetlamp"

	desired_light_power = 0.5
	desired_light_range = 4
	desired_light_color = "#FFFFB5"

	layer = LAYER_MOB_ABOVE

	plane = PLANE_MOB

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	collision_dir = NORTH | EAST | SOUTH | WEST

	density = TRUE

/obj/structure/interactive/lighting/streetlamp/strong
	desired_light_power = 0.4
	desired_light_range = 8

/obj/structure/interactive/lighting/streetlamp/snow
	icon_state = "streetlamp_snow"

/obj/structure/interactive/lighting/streetlamp/jungle
	icon_state = "torch"

/obj/structure/interactive/lighting/streetlamp/jungle/dark
	icon_state = "torch_dark"



