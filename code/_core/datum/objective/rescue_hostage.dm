var/global/list/possible_hostage_types = list(
	/mob/living/advanced/npc/unique/hostage/clown,
	/mob/living/advanced/npc/unique/hostage/assistant,
	/mob/living/advanced/npc/unique/hostage/scientist
)

/objective/hostage
	name = "Rescue Hostage"
	desc = "Rescue \the #TARGET located at #LOCATION."

	var/mob/living/created_hostage

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

/objective/hostage/proc/hostage_post_move(var/mob/caller,args)

	if(caller.z == 2 && caller.x > 119)
		update()

	return TRUE

/objective/hostage/proc/hostage_Destroy(var/mob/caller,args)
	update()
	return TRUE

/objective/hostage/start()
	HOOK_ADD("post_move","hostage_post_move",created_hostage,src,.proc/hostage_post_move)
	HOOK_ADD("Destroy","hostage_Destroy",created_hostage,src,.proc/hostage_Destroy)
	tracked_atoms += created_hostage