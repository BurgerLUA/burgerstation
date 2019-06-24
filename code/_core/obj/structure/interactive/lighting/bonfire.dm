/obj/structure/interactive/lighting/bonfire
	name = "bonfire"
	desc = "a large bonfire"

	opacity = 0

	icon = 'icons/obj/structure/medieval/bonfire.dmi'
	icon_state = "bonfire"

	light_power = 0
	light_range = 2
	light_color = "#FF7F00"


/obj/structure/interactive/lighting/bonfire/on
	icon_state = "bonfire_warm"
	light_power = 0.5
	light_range = 4


/obj/structure/interactive/lighting/bonfire/on/intense
	icon_state = "bonfire_on_fire"
	light_power = 0.75
	light_range = 8