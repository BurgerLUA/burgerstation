/objective/defense
	name = "Defend Supermatter"

	var/obj/structure/interactive/supermatter/defend

	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 10

/objective/defense/on_gamemode_playable()

	announce(
		"Central Command Mission Update",
		"Supermatter Defense",
		"Our bluespace drives are ready to teleport the Supermatter Crystal once it is charged with emitter energy. Please activate the emitters to start the charging process.",
		ANNOUNCEMENT_STATION
	)

	var/gamemode/G = SSgamemode.active_gamemode

	if(istype(G,/gamemode/horde))
		var/gamemode/horde/H = G
		H.priority_targets |= defend

	return ..()

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
		log_error("No supermatter spawns found for defense objective!")
		return FALSE
	var/obj/marker/S = pick(possible_supermatter_spawns)
	possible_supermatter_spawns -= S
	defend = new /obj/structure/interactive/supermatter(get_turf(S))
	INITIALIZE(defend)
	GENERATE(defend)
	FINALIZE(defend)
	return TRUE

/objective/defense/check_completion()

	if(defend.qdeleting)
		if(defend.charge >= defend.charge_max)
			return COMPLETED
		else
			return FAILED

	return ..()

/objective/defense/proc/defense_Destroy(var/obj/structure/interactive/supermatter/S,args)
	update()
	return TRUE

/objective/defense/start()
	HOOK_ADD("Destroy","defense_Destroy",defend,src,.proc/defense_Destroy)
	tracked_atoms += defend
	return TRUE