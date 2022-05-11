/gamemode/nuke_ops/proc/round_start()
	state = 2
	log_debug("Setting VR state to 2 due to round_start()")
	cleanup_map()
	setup_markers()
	setup_spawnpoints()
	if(round == 0)
		set_teams()
	else
		if(!(round % 5))
			swap_teams()
		if(!(round % 10))
			SSvote.create_vote(/vote/continue_round)

	insert_latejoiners()

	place_mobs_at_spawn()

	round++
	state = 3
	log_debug("Setting VR state to 3 due to round_start()")
	time_left = 5 //Seconds

/gamemode/nuke_ops/proc/place_mobs_at_spawn()

	for(var/k in teams["NanoTrasen"])
		var/mob/living/L = k
		var/turf/T = pick(valid_nanotrasen_turfs)
		if(length(valid_nanotrasen_turfs) > 4)
			valid_nanotrasen_turfs -= T
		setup_player(L,T)

	for(var/k in teams["Syndicate"])
		var/mob/living/L = k
		var/turf/T = pick(valid_syndicate_turfs)
		if(length(valid_syndicate_turfs) > 4)
			valid_syndicate_turfs -= T
		setup_player(L,T)