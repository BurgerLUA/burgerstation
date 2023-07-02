/objective/hostage
	name = "Rescue Hostage"

	var/mob/living/created_hostage

	var/completed = FALSE

	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 15

/objective/hostage/get_description()
	return "Rescue [english_list(tracked_atoms)] and bring them shipside. Location: [english_list(get_locations(),"Unknown")]."

/objective/hostage/setup()
	if(!length(possible_hostage_spawns))
		return FALSE
	var/obj/marker/hostage_spawn/S = pick(possible_hostage_spawns)
	if(!S)
		return FALSE
	possible_hostage_spawns -= S
	var/mob/living/advanced/npc/hostage/L = new(get_turf(S))
	INITIALIZE(L)
	FINALIZE(L)
	var/obj/item/handcuffs/H = new(get_turf(L))
	INITIALIZE(H)
	GENERATE(H)
	FINALIZE(H)
	L.set_handcuffs(TRUE,H)
	created_hostage = L
	return TRUE

/objective/hostage/proc/get_valid_targets()
	return list(created_hostage)

/objective/hostage/proc/has_valid_targets()
	return length(get_valid_targets()) ? TRUE : FALSE

/objective/hostage/proc/get_random_target()

	var/list/valid_targets = get_valid_targets()

	if(!length(valid_targets))
		return FALSE

	return pick(valid_targets)

/objective/hostage/check_completion()

	if(completed)
		return COMPLETED

	if(!created_hostage || created_hostage.qdeleting || created_hostage.dead)
		return FAILED

	return ACTIVE


/objective/hostage/proc/hostage_post_move(var/mob/living/advanced/npc/hostage/H,args)

	if(!completed && !H.dead)
		var/area/A = get_area(H)
		if(istype(A,/area/burgerstation))
			completed = TRUE
			if(H.ai)
				var/turf/T = get_turf(pick(possible_hostage_rest_markers))
				H.ai.set_path_fallback(T)
			update()

	return TRUE

/objective/hostage/proc/hostage_Destroy(var/mob/living/advanced/npc/hostage/H,args)
	update()
	return TRUE

/objective/hostage/proc/hostage_post_death(var/mob/living/advanced/npc/hostage/H,args)
	update()
	return TRUE

/objective/hostage/start()
	HOOK_ADD("post_move","hostage_post_move",created_hostage,src,src::hostage_post_move())
	HOOK_ADD("post_death","hostage_post_death",created_hostage,src,src::hostage_post_death())
	HOOK_ADD("Destroy","hostage_Destroy",created_hostage,src,src::hostage_Destroy())
	tracked_atoms += created_hostage
	return TRUE