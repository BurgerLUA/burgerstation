/mob/abstract/observer/
	name = "observer"
	desc = "It's a ghost!"
	icon = 'icons/mob/abstract/ghosts.dmi'
	icon_state = "basic"
	ghost = TRUE
	layer = LAYER_GHOST

/mob/abstract/observer/Initialize()
	. = ..()
	name = "ghost of [ckey]"
	src << "You are a ghost!"
	sight |= SEE_THRU

	client.known_inventory = list()
	client.known_buttons = list()
	client.known_health_elements = list()
	client.screen = list()