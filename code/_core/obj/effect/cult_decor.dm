obj/effect/cult_decor //TODO: Figure out if this is a good idea.
	name = "cult decor"
	mouse_opacity = 1
	layer = LAYER_FLOOR_DECAL
	icon = 'icons/obj/structure/cult/effects.dmi'

	desired_light_power = 0.5
	desired_light_range = 2
	desired_light_color = "#FF0000"

obj/effect/cult_decor/floor
	icon_state = "floorglow"

obj/effect/cult_decor/wall
	icon_state = "wallglow"