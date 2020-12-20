/objective/kill_ghost
	name = "Kill Ghost"
	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 25

	trackable = FALSE

/objective/kill_ghost/setup()

	if(!has_valid_targets())
		log_error("Objective [src.type] has no valid targets.")
		return FALSE

	return ..()

/objective/kill_ghost/proc/get_valid_targets()
	. = list()
	for(var/mob/living/simple/ghost/G in world)
		if(G.dead || G.qdeleting)
			continue
		. += G
	return

/objective/kill_ghost/proc/has_valid_targets()
	return length(get_valid_targets()) ? TRUE : FALSE

/objective/kill_ghost/proc/get_random_target()

	var/list/valid_targets = get_valid_targets()

	if(!length(valid_targets))
		return FALSE

	return pick(valid_targets)

/objective/kill_ghost/get_description()
	return "Stop the haunting of [english_list(get_locations())] . Location: [english_list(get_locations())]."

/objective/kill_ghost/start()
	var/mob/living/L = get_random_target()
	tracked_atoms += L
	HOOK_ADD("post_death","kill_ghost_death",L,src,.proc/kill_ghost_post_death)
	HOOK_ADD("destroy","kill_ghost_destroy",L,src,.proc/kill_ghost_post_death)
	update()
	return ..()

/objective/kill_ghost/proc/kill_ghost_post_death(var/mob/living/L,args)

	if(L.dead || L.qdeleting)
		update()

	return TRUE

/objective/kill_ghost/check_completion()

	for(var/k in tracked_atoms)
		var/mob/living/L = k
		if(!(L.dead || L.qdeleting))
			return ACTIVE

	return COMPLETED