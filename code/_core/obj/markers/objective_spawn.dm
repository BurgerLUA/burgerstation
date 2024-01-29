var/global/list/possible_objective_spawns = list()

/obj/marker/objective_spawn
	name = "possible objective spawn"
	icon_state = "goal"

/obj/marker/objective_spawn/New(desired_loc)
	if(!SSdmm_suite.is_pvp_coord(loc.x,loc.y,loc.z))
		possible_objective_spawns += src
	return ..()


var/global/list/possible_abnormality_spawns = list()

/obj/marker/abnormality_spawn
	name = "possible objective spawn"
	icon_state = "goal"
	color = "#FF0000"

/obj/marker/abnormality_spawn/New(desired_loc)
	possible_abnormality_spawns += src
	return ..()