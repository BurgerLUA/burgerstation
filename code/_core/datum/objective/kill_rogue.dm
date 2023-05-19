var/global/list/tracked_rogues = list()

/objective/kill_rogue
	name = "Kill Rogue Crewmember"
	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 15

/objective/kill_rogue/setup()

	if(!has_valid_targets())
		log_error("Objective [src.type] has no valid targets.")
		return FALSE

	return ..()

/objective/kill_rogue/proc/get_valid_targets()

	var/list/possible_rogue_crewmembers = SSbosses.tracked_rogue_crewmembers - tracked_rogues

	for(var/k in possible_rogue_crewmembers)
		var/mob/living/L = k
		if(!L.z || L.z != SSdmm_suite.file_to_z_level["maps/_core/mission.dmm"])
			possible_rogue_crewmembers -= k
			continue
		if(SSdmm_suite.is_pvp_coord(L.x,L.y,L.z))
			possible_rogue_crewmembers -= k
			continue

	return possible_rogue_crewmembers

/objective/kill_rogue/proc/has_valid_targets()
	return length(get_valid_targets()) ? TRUE : FALSE

/objective/kill_rogue/proc/get_random_target()

	var/list/valid_targets = get_valid_targets()

	if(!length(valid_targets))
		return FALSE

	return pick(valid_targets)

/objective/kill_rogue/get_description()
	return "Kill [english_list(tracked_atoms)]. Location: [english_list(get_locations(),"Unknown")]."

/objective/kill_rogue/start()
	var/mob/living/L = get_random_target()
	tracked_rogues += L //Global list
	tracked_atoms += L
	HOOK_ADD("post_death","kill_rogue_post_death",L,src,src::kill_boss_post_death())
	HOOK_ADD("Destroy","kill_rogue_destroy",L,src,src::kill_boss_destroy())
	update()
	return ..()

/objective/kill_rogue/proc/kill_boss_destroy(var/mob/living/L,args)
	update()
	return TRUE

/objective/kill_rogue/proc/kill_boss_post_death(var/mob/living/L,args)

	if(L.dead || L.qdeleting)
		update()

	return TRUE

/objective/kill_rogue/check_completion()

	for(var/k in tracked_atoms)
		var/mob/living/L = k
		if(L && !L.dead && !L.qdeleting)
			return ACTIVE

	return COMPLETED