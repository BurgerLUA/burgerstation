/objective/kill_blob
	name = "Kill Rogue Crewmember"
	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 15

/objective/kill_blob/setup()

	if(!length(possible_blob_locations))
		return FALSE

	return ..()


/objective/kill_blob/get_description()
	return "Destroy [english_list(tracked_atoms)]. Location: [english_list(get_locations(),"Unknown")]."

/objective/kill_blob/start()
	var/obj/marker/M = pick(possible_blob_locations)
	possible_blob_locations -= M
	var/obj/structure/interactive/blob/core/B = new(get_turf(M))
	B.blob_limit *= 5
	B.fast_grows_left *= 2
	INITIALIZE(B)
	FINALIZE(B)
	tracked_atoms += B
	HOOK_ADD("Destroy","kill_blob_destroy",B,src,src::kill_blob_destroy())
	update()
	return ..()

/objective/kill_blob/proc/kill_blob_destroy(var/obj/structure/interactive/blob/core/B,args)
	update()
	return TRUE

/objective/kill_blob/check_completion()

	for(var/k in tracked_atoms)
		var/obj/structure/interactive/blob/core/B = k
		if(B && !B.qdeleting)
			return ACTIVE

	return COMPLETED