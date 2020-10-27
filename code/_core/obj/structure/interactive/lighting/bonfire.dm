/obj/structure/interactive/lighting/bonfire //TODO: Make it cook.
	name = "bonfire"
	desc = "a large bonfire"

	opacity = 0

	icon = 'icons/obj/structure/bonfire.dmi'
	icon_state = "bonfire"

	desired_light_power = 0
	desired_light_range = 2
	desired_light_color = "#FF7F00"


/obj/structure/interactive/lighting/bonfire/on
	icon_state = "bonfire_warm"
	desired_light_power = 0.5
	desired_light_range = 4


/obj/structure/interactive/lighting/bonfire/on/intense
	icon_state = "bonfire_on_fire"
	desired_light_power = 0.75
	desired_light_range = 8