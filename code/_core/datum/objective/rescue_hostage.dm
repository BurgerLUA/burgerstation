var/global/list/possible_hostage_types = list(
	/mob/living/advanced/npc/unique/hostage/clown,
	/mob/living/advanced/npc/unique/hostage/assistant,
	/mob/living/advanced/npc/unique/hostage/scientist
)

/objective/hostage
	name = "Rescue Hostage"

	var/mob/living/created_hostage

	var/completed = FALSE

/objective/hostage/get_description()
	return "Rescue [english_list(tracked_atoms)] and bring them shipside. Location: [english_list(get_locations())]."

/objective/hostage/setup()
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
	var/obj/item/handcuffs/H = new(get_turf(L))
	INITIALIZE(H)
	GENERATE(H)
	L.set_handcuffs(TRUE,H)
	created_hostage = L
	return TRUE

/objective/hostage/get_valid_targets()
	return list(created_hostage)

/objective/hostage/check_completion()

	if(completed)
		return COMPLETED

	if(!created_hostage || created_hostage.qdeleting || created_hostage.dead)
		return FAILED

	return ACTIVE


/objective/hostage/proc/hostage_post_move(var/mob/living/advanced/npc/unique/hostage/H,args)

	if(H.z == 2 && H.x > 119)
		completed = TRUE
		update()

	return TRUE

/objective/hostage/proc/hostage_Destroy(var/mob/living/advanced/npc/unique/hostage/H,args)
	update()
	return TRUE

/objective/hostage/start()
	HOOK_ADD("post_move","hostage_post_move",created_hostage,src,.proc/hostage_post_move)
	HOOK_ADD("Destroy","hostage_Destroy",created_hostage,src,.proc/hostage_Destroy)
	tracked_atoms += created_hostage