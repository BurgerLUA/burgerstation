var/global/list/atom/movable/possible_abnormalities = list(
	/obj/structure/interactive/the_curse
)

/objective/abnormality
	name = "Contain Abnormality"

	var/atom/movable/abnormality

	var/completed = FALSE
	var/failed = FALSE

	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 10

/objective/abnormality/proc/get_valid_targets()
	return list(abnormality)

/objective/abnormality/proc/has_valid_targets()
	return length(get_valid_targets()) ? TRUE : FALSE

/objective/abnormality/proc/get_random_target()

	var/list/valid_targets = get_valid_targets()

	if(!length(valid_targets))
		return FALSE

	return pick(valid_targets)

/objective/abnormality/get_description()
	return "Contain the unknown anomaly and bring it shipside into the science containment area. Location: [english_list(get_locations(),"Unknown")]."

/objective/abnormality/setup()
	if(!length(possible_abnormality_spawns))
		return FALSE
	if(!length(possible_abnormalities))
		return FALSE
	var/obj/marker/S = pick(possible_abnormality_spawns)
	if(!S) return FALSE
	possible_abnormality_spawns -= S
	abnormality = pick(possible_abnormalities)
	possible_abnormalities -= abnormality
	abnormality = new abnormality(get_turf(S))
	INITIALIZE(abnormality)
	GENERATE(abnormality)
	FINALIZE(abnormality)
	return TRUE

/objective/abnormality/check_completion()
	if(failed)
		return FAILED
	if(completed)
		return COMPLETED
	return ..()

/objective/abnormality/proc/abnormality_post_move(var/atom/movable/M,args)
	if(!completed)
		var/area/A = get_area(M)
		if(istype(A,/area/burgerstation/science/containment))
			completed = TRUE
			update()
			qdel(M)

	return TRUE

/objective/abnormality/proc/abnormality_Destroy(var/atom/movable/M,args)
	if(!completed)
		failed = TRUE
		update()
	return TRUE

/objective/abnormality/start()
	HOOK_ADD("post_move","abnormality_post_move",abnormality,src,.proc/abnormality_post_move)
	HOOK_ADD("Destroy","abnormality_Destroy",abnormality,src,.proc/abnormality_Destroy)
	tracked_atoms += abnormality
	return TRUE