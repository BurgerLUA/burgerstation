var/global/list/lobby_positions = list()

/obj/marker/lobby
	name = "lobby position"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "lobby"

/obj/marker/lobby/New()
	..()
	lobby_positions += src