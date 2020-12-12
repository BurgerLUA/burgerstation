var/global/time_dialation = 0

/world/proc/life()

	world_log("Starting world...")

	world_state = STATE_INITIALIZING

	for(var/subsystem in subtypesof(/subsystem/))
		var/subsystem/S = subsystem
		if(!initial(S.priority))
			log_subsystem("Subsystem Controller","ERROR: COUNT NOT LOAD SUBSYSTEM [S.name].")
			continue
		S = new subsystem
		active_subsystems += S

	log_subsystem("Subsystem Controller","Created [length(active_subsystems)] subsystems.")

	sortTim(active_subsystems, /proc/cmp_subsystem_priority)

	log_subsystem("Subsystem Controller","[length(active_subsystems)] subsystems sorted.")

	var/benchmark = world.timeofday

	for(var/k in active_subsystems)
		var/subsystem/SS = k
		var/local_benchmark = world.timeofday
		log_subsystem(SS.name,"Initializing...")
		INITIALIZE(SS)
		log_subsystem(SS.name,"Initialization took [DECISECONDS_TO_SECONDS((world.timeofday - local_benchmark))] seconds.")

	log_subsystem("Subsystem Controller","[length(active_subsystems)] subsystems initialized.")

	log_subsystem("Subsystem Controller","All initializations took [DECISECONDS_TO_SECONDS((world.timeofday - benchmark))] seconds.")

	//log_debug("Starting new round (ID: [SSlogging.round_id]). Join at <byond://[world.internet_address]:[world.port]>! <@&695106439911571516>")

	//SSdiscord.send_message("Starting new round (ID: [SSlogging.round_id]). Join at <byond://[world.internet_address]:[world.port]>! <@&695106439911571516>")

	for(var/k in active_subsystems)
		var/subsystem/SS = k
		spawn while(SS.tick_rate > 0 && world_state != STATE_SHUTDOWN)
			if(SS.overtime_count < SS.overtime_max)
				if(SS.cpu_usage_max > 0 && world.cpu > SS.cpu_usage_max)
					SS.overtime_count++
					sleep(TICK_LAG)
					continue
				if(SS.tick_usage_max > 0 && world.tick_usage > SS.tick_usage_max)
					SS.overtime_count++
					sleep(TICK_LAG)
					continue
			SS.overtime_count = 0
			var/start_time = world.time

			var/result = SS.on_life()
			if(result == null)
				log_error("[SS.name] failed to run properly!")
				sleep(10)
				continue
			else if(result == FALSE)
				log_subsystem(SS.name,"Shutting down.")
				break
			SS.last_run_duration = FLOOR(world.time - start_time,0.01)
			SS.total_run_duration += SS.last_run_duration
			if(time_dialation && SS.use_time_dialation)
				sleep(TICKS_TO_DECISECONDS(SS.tick_rate*time_dialation))
			else
				sleep(TICKS_TO_DECISECONDS(SS.tick_rate))

	world_state = STATE_RUNNING

	if(ENABLE_INSTALOAD)
		for(var/mob/abstract/observer/menu/O in all_mobs_with_clients)
			if(!O.load_most_recent_character())
				O.new_character()

	else if(length(lobby_positions))
		for(var/mob/abstract/observer/menu/O in all_mobs_with_clients)
			var/list/possible_music = TRACKS_LOBBY
			var/lobby_track = 1 + (SSlogging.round_id % length(possible_music))
			O.force_move(get_turf(pick(lobby_positions)))
			play_music_track(possible_music[lobby_track], O.client)
			O.show_hud(TRUE,speed = 2)

	log_subsystem("Subsystem Controller","Life initializations complete.")

	update_server_status()

	return TRUE