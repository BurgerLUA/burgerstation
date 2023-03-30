/obj/effect/crack
	name = "crack"
	mouse_opacity = 0
	icon = 'icons/obj/effects/crack.dmi'
	icon_state = "1"
	alpha = 20
	color = "#000000"
	plane = PLANE_FLOOR_ATTACHMENT
	layer = LAYER_FLOOR_WEATHER

/obj/effect/crack/New(var/desired_loc)
	. = ..()
	icon_state = "[rand(1,9)]"


/obj/effect/moss
	name = "moss"
	mouse_opacity = 0
	icon = 'icons/obj/effects/brick_moss.dmi'
	icon_state = "1"
	alpha = 100
	color = "#007F0E"
	plane = PLANE_FLOOR_ATTACHMENT
	layer = LAYER_FLOOR_CARPET

/obj/effect/moss/New(var/desired_loc)
	. = ..()
	color = rgb(0,rand(115,140),0)
	icon_state = "[rand(1,3)]"