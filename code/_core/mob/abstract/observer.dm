/mob/abstract/observer/
	name = "observer"
	desc = "It's a ghost!"
	icon = 'icons/mob/abstract/ghosts.dmi'
	icon_state = "basic"

/mob/abstract/observer/Initialize()
	. = ..()
	name = ckey
	src << "You are a ghost! Move to the edge of the map if you wish to spawn as a living being."