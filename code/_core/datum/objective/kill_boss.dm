var/list/possible_boss_targets


/objective/kill_boss
	name = "Kill Boss"

/objective/kill_boss/setup()

	if(!possible_boss_targets)
		possible_boss_targets = SSbosses.living_bosses.Copy()

	return ..()

/objective/kill_boss/get_description()
	return "Kill [english_list(tracked_atoms)]. Location: [english_list(get_locations())]."

/objective/kill_boss/get_valid_targets()
	return possible_boss_targets

/objective/kill_boss/start()
	var/mob/living/L = get_random_target()
	possible_boss_targets -= L
	tracked_atoms += L
	HOOK_ADD("post_death","kill_boss_post_death",L,src,.proc/kill_boss_post_death)
	update()
	return ..()

/objective/kill_boss/proc/kill_boss_post_death(var/mob/living/L,args)

	if(L.dead || L.qdeleting)
		update()

	return TRUE

/objective/kill_boss/check_completion()

	for(var/mob/living/L in tracked_atoms)
		if(!(L.dead || L.qdeleting))
			return ACTIVE

	return COMPLETED