/world/proc/subsystem_life_loop(subsystem/SS)
	set background = TRUE
	spawn while(SS.tick_rate > 0 && world_state < STATE_SHUTDOWN)
		if(SS.tick_rate > 0 && SS.overtime_count < SS.overtime_max)
			if(world_state >= STATE_RUNNING && SS.tick_usage_max > 0 && world.tick_usage > SS.tick_usage_max)
				SS.overtime_count++
				sleep(1 TICKS)
				continue
		SS.overtime_count = 0
		var/result = SS.on_life()
		if(result == null)
			log_error("[SS.name] failed to run properly!")
			SS.run_failures++
			if(SS.run_failures >= 3)
				log_error("[SS.name] failed to run properly for the third time in a row, unclogging...")
				SS.run_failures = 0
				SS.unclog()
			sleep(10)
			continue
		else if(result == FALSE || SS.tick_rate <= 0)
			SS.tick_rate = 0
			log_subsystem(SS.name,"Shutting down.")
			break
		SS.run_failures = 0

		sleep(TICKS2DS(SS.tick_rate))

		while(world_state <= STATE_INITIALIZING)
			sleep(10)

/world/proc/subsystem_initialize(subsystem/SS)
	//No background processing. Everything needs to run in order.
	var/local_benchmark = true_time()
	log_subsystem(SS.name,"Initializing...")
	INITIALIZE(SS)
	FINALIZE(SS)
	var/benchmark_time = DECISECONDS_TO_SECONDS((true_time() - local_benchmark))
	switch(benchmark_time)
		if(1 to 10)
			log_subsystem(SS.name,"Initialization took [benchmark_time] seconds.")
		if(10 to 30)
			log_subsystem(SS.name,"Initialization took <b>[benchmark_time]</b> seconds.")
		if(30 to 60)
			log_subsystem(SS.name,"Initialization took <b style='color:red'>[benchmark_time]</b> seconds.")
		if(60 to INFINITY)
			log_subsystem(SS.name,"<b style='color:red'>Initialization took [benchmark_time] seconds.</b>")
	CHECK_TICK_HARD

/world/proc/life()

	var/benchmark = true_time()

	world_log("Starting world...")

	if(world.port == 0)
		Profile(PROFILE_START)

	world_state = STATE_INITIALIZING

	for(var/subsystem in subtypesof(/subsystem/))
		var/subsystem/S = subsystem
		if(!initial(S.priority))
			log_subsystem("Subsystem Controller","ERROR: COUNT NOT LOAD SUBSYSTEM [S.name].")
			continue
		S = new subsystem
		active_subsystems += S

	sort_tim(active_subsystems, /proc/cmp_subsystem_priority)

	log_subsystem("Subsystem Controller","Created and sorted [length(active_subsystems)] subsystems sorted.")

	CHECK_TICK_HARD

	for(var/k in active_subsystems)
		var/subsystem/SS = k
		if(!SS)
			active_subsystems -= k
			log_error("FATAL ERROR: There was a subsystem in the active_substyems list that was null!")
			continue
		if(SS.qdeleting)
			active_subsystems -= k
			log_error("FATAL ERROR: Subsystem [SS.get_debug_name()] was qdeleting!")
			continue
		subsystem_initialize(SS)
		subsystem_life_loop(SS)

	var/final_time_text = "All initializations took <b>[DECISECONDS_TO_SECONDS((true_time() - benchmark))]</b> seconds."
	log_subsystem("Subsystem Controller","[length(active_subsystems)] subsystems initialized.")
	log_subsystem("Subsystem Controller",final_time_text)
	log_debug(final_time_text)

	CHECK_TICK_HARD

	world_state = STATE_RUNNING

	var/list/possible_music = TRACKS_LOBBY
	var/lobby_track = 1 + (SSlogging.round_id % length(possible_music))

	var/turf/move_turf
	if(length(lobby_positions))
		move_turf = get_turf(pick(lobby_positions))
	else
		move_turf = locate(1,1,1)

	for(var/mob/abstract/observer/menu/O in SSliving.all_mobs_with_clients)
		O.force_move(move_turf)
		play_music_track(possible_music[lobby_track], O.client)
		O.show_hud(TRUE,speed = 2 SECONDS)
		CHECK_TICK_HARD

	log_subsystem("Subsystem Controller","Life initializations complete.")

	update_server_status()

	if(world.port == 0)
		Profile(PROFILE_STOP)

	return TRUE
