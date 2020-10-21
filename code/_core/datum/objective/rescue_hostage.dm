var/global/list/possible_hostage_types = list(
	/mob/living/advanced/npc/unique/hostage/clown,
	/mob/living/advanced/npc/unique/hostage/assistant,
	/mob/living/advanced/npc/unique/hostage/scientist
)

/objective/hostage
	name = "Rescue Hostage"

	var/mob/living/created_hostage

	var/completed = FALSE

	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 15

/objective/hostage/get_description()
	return "Rescue [english_list(tracked_atoms)] and bring them shipside. Location: [english_list(get_locations())]."

/objective/hostage/setup()
	if(!length(possible_hostage_spawns))
		return FALSE
	var/obj/marker/hostage_spawn/S = pick(possible_hostage_spawns)
	if(!S)
		return FALSE
	possible_hostage_spawns -= S
	var/mob/living/advanced/npc/unique/hostage/L = pick(possible_hostage_types)
	if(!L)
		return FALSE
	possible_hostage_types -= L
	L = new L(get_turf(S))
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


/objective/hostage/proc/hostage_post_move(var/mob/living/advanced/npc/unique/hostage/H,args)

	if(!completed && H.z == Z_LEVEL_STATION && !H.dead)
		var/area/A = get_area(H)
		if(istype(A,/area/burgerstation))
			completed = TRUE
			if(H.ai)
				var/turf/T = get_turf(pick(possible_hostage_rest_markers))
				var/obj/marker/map_node/N_start = find_closest_node(H)
				if(N_start)
					var/obj/marker/map_node/N_end = find_closest_node(T)
					if(N_end)
						var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)
						if(found_path)
							H.ai.set_path(found_path)

			update()

	return TRUE

/objective/hostage/proc/hostage_Destroy(var/mob/living/advanced/npc/unique/hostage/H,args)
	update()
	return TRUE

/objective/hostage/proc/hostage_post_death(var/mob/living/advanced/npc/unique/hostage/H,args)
	update()
	return TRUE

/objective/hostage/start()
	HOOK_ADD("post_move","hostage_post_move",created_hostage,src,.proc/hostage_post_move)
	HOOK_ADD("post_death","hostage_post_death",created_hostage,src,.proc/hostage_post_death)
	HOOK_ADD("Destroy","hostage_Destroy",created_hostage,src,.proc/hostage_Destroy)
	tracked_atoms += created_hostage
	return TRUE