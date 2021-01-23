var/global/list/possible_supermatter_spawns = list()

/obj/marker/supermatter_spawn
	name = "possible supermatter spawn"
	icon_state = "goal"

/obj/marker/supermatter_spawn/New(var/desired_loc)
	possible_supermatter_spawns += src
	return ..()