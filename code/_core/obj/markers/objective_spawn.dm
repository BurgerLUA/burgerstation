var/global/list/possible_objective_spawns = list()

/obj/marker/objective_spawn
	name = "possible objective spawn"
	icon_state = "goal"

/obj/marker/objective_spawn/New(var/desired_loc)
	possible_objective_spawns += src
	return ..()