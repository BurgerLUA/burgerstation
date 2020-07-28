/objective/artifact
	name = "Obtain Artifact"

	var/obj/structure/interactive/artifact/created_artifact

	var/completed = FALSE

/objective/artifact/get_description()
	return "Obtain [english_list(tracked_atoms)] and bring it shipside. Location: [english_list(get_locations())]."

/objective/artifact/setup()
	var/obj/marker/objective_spawn/S = pick(possible_objective_spawns)
	if(!S) return FALSE
	possible_objective_spawns -= S
	created_artifact = new /obj/structure/interactive/artifact(get_turf(S))
	INITIALIZE(created_artifact)
	GENERATE(created_artifact)
	return TRUE

/objective/artifact/get_valid_targets()
	return list(created_artifact)

/objective/artifact/check_completion()
	if(completed)
		return COMPLETED
	return ..()

/objective/artifact/proc/artifact_post_move(var/obj/structure/interactive/artifact/A,args)

	if(A.z == 2 && A.x > 119)
		completed = TRUE
		update()

	return TRUE

/objective/artifact/proc/artifact_Destroy(var/obj/structure/interactive/artifact/A,args)
	update()
	return TRUE

/objective/artifact/start()
	HOOK_ADD("post_move","artifact_post_move",created_artifact,src,.proc/artifact_post_move)
	HOOK_ADD("Destroy","artifact_Destroy",created_artifact,src,.proc/artifact_Destroy)
	tracked_atoms += created_artifact