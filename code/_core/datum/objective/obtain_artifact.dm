/objective/artifact
	name = "Obtain Artifact"

	var/obj/structure/interactive/artifact/created_artifact

	var/completed = FALSE

	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 10

/objective/artifact/proc/get_valid_targets()
	return list(created_artifact)

/objective/artifact/proc/has_valid_targets()
	return length(get_valid_targets()) ? TRUE : FALSE

/objective/artifact/proc/get_random_target()

	var/list/valid_targets = get_valid_targets()

	if(!length(valid_targets))
		return FALSE

	return pick(valid_targets)

/objective/artifact/get_description()
	return "Obtain [english_list(tracked_atoms)] and bring it shipside. Location: [english_list(get_locations())]."

/objective/artifact/setup()
	if(!length(possible_objective_spawns))
		return FALSE
	var/obj/marker/objective_spawn/S = pick(possible_objective_spawns)
	if(!S) return FALSE
	possible_objective_spawns -= S
	created_artifact = new /obj/structure/interactive/artifact(get_turf(S))
	INITIALIZE(created_artifact)
	GENERATE(created_artifact)
	FINALIZE(created_artifact)
	return TRUE

/objective/artifact/check_completion()
	if(completed)
		return COMPLETED
	return ..()

/objective/artifact/proc/artifact_post_move(var/obj/structure/interactive/artifact/H,args)
	if(!completed && H.z == Z_LEVEL_STATION)
		var/area/A = get_area(H)
		if(istype(A,/area/burgerstation))
			completed = TRUE
			update()

	return TRUE

/objective/artifact/proc/artifact_Destroy(var/obj/structure/interactive/artifact/A,args)
	completed = TRUE
	update()
	return TRUE

/objective/artifact/start()
	HOOK_ADD("post_move","artifact_post_move",created_artifact,src,.proc/artifact_post_move)
	HOOK_ADD("Destroy","artifact_Destroy",created_artifact,src,.proc/artifact_Destroy)
	tracked_atoms += created_artifact
	return TRUE