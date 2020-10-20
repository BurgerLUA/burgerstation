var/list/tracked_bosses = list()

/objective/kill_boss
	name = "Kill Boss"
	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 15

/objective/kill_boss/setup()

	if(!has_valid_targets())
		log_error("Objective [src.type] has no valid targets.")
		return FALSE

	return ..()

/objective/kill_boss/proc/get_valid_targets()
	return SSbosses.living_bosses - tracked_bosses

/objective/kill_boss/proc/has_valid_targets()
	return length(get_valid_targets()) ? TRUE : FALSE

/objective/kill_boss/proc/get_random_target()

	var/list/valid_targets = get_valid_targets()

	if(!length(valid_targets))
		return FALSE

	return pick(valid_targets)

/objective/kill_boss/get_description()
	return "Kill [english_list(tracked_atoms)]. Location: [english_list(get_locations())]."

/objective/kill_boss/start()
	var/mob/living/L = get_random_target()
	tracked_bosses += L //Global list
	tracked_atoms += L
	HOOK_ADD("post_death","kill_boss_post_death",L,src,.proc/kill_boss_post_death)
	HOOK_ADD("destroy","kill_boss_destroy",L,src,.proc/kill_boss_post_death)
	update()
	return ..()

/objective/kill_boss/proc/kill_boss_post_death(var/mob/living/L,args)

	if(L.dead || L.qdeleting)
		update()

	return TRUE

/objective/kill_boss/check_completion()

	for(var/k in tracked_atoms)
		var/mob/living/L = k
		if(!(L.dead || L.qdeleting))
			return ACTIVE

	return COMPLETED