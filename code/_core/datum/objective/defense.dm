/objective/defense
	name = "Defend Object"

	var/obj/structure/defend

	var/defense_end_time = -1

	var/completed = FALSE

	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 10

/objective/defense/proc/get_valid_targets()
	return list(defend)

/objective/defense/proc/has_valid_targets()
	return length(defend) ? TRUE : FALSE

/objective/defense/proc/get_random_target()

	var/list/valid_targets = get_valid_targets()

	if(!length(valid_targets))
		return FALSE

	return pick(valid_targets)

/objective/defense/get_description()
	return "Defend [english_list(tracked_atoms)] until we can teleport it safely. Location: [english_list(get_locations())]."

/objective/defense/setup()
	if(!length(possible_supermatter_spawns))
		return FALSE
	var/obj/marker/S = pick(possible_supermatter_spawns)
	if(!S) return FALSE
	possible_supermatter_spawns -= S
	defend = new /obj/structure/interactive/supermatter(get_turf(S))
	INITIALIZE(defend)
	GENERATE(defend)
	FINALIZE(defend)
	return TRUE

/objective/defense/check_completion()
	if(completed)
		return COMPLETED
	return ..()

/objective/defense/proc/defense_Destroy(var/obj/structure/interactive/artifact/A,args)
	update()
	return TRUE

/objective/defense/start()
	HOOK_ADD("Destroy","defense_Destroy",defend,src,.proc/defense_Destroy)
	tracked_atoms += defend
	return TRUE