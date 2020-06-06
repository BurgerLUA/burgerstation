
/world/proc/life()
	set background = TRUE

	LOG_SERVER("STARTING WORLD.")

	update_status()

	world_state = STATE_INITIALIZING

	for(var/subsystem in subtypesof(/subsystem/))
		var/subsystem/S = new subsystem
		if(!S.priority)
			log_subsystem("Subsystem Controller","ERROR: COUNT NOT LOAD SUBSYSTEM [S.name].")
			qdel(S)
			continue
		active_subsystems += S

	active_subsystems = sortTim(active_subsystems, /proc/cmp_subsystem_priority)

	log_subsystem("Subsystem Controller","[length(active_subsystems)] subsystems loaded.")

	var/benchmark = world.timeofday

	for(var/subsystem/S in active_subsystems)
		var/local_benchmark = world.timeofday
		log_subsystem(S.name,"Initializing...")
		INITIALIZE(S)
		log_subsystem(S.name,"Initialization took [DECISECONDS_TO_SECONDS((world.timeofday - local_benchmark))] seconds.")

	log_subsystem("Subsystem Controller","All initializations took [DECISECONDS_TO_SECONDS((world.timeofday - benchmark))] seconds.")

	world_state = STATE_RUNNING

	if(ENABLE_INSTALOAD)
		for(var/mob/abstract/observer/menu/O in all_mobs_with_clients)
			if(!O.load_most_recent_character())
				O.new_character()

	else if(length(lobby_positions))
		for(var/mob/abstract/observer/menu/O in all_mobs_with_clients)
			O.force_move(get_turf(pick(lobby_positions)))
			play_music_track("slow_fall", O.client)

	for(var/subsystem/SS in active_subsystems)
		spawn
			while(SS.tick_rate > 0 && world_state != STATE_SHUTDOWN)
				if(world.cpu > SS.cpu_usage_max)
					sleep(TICK_LAG)
					continue
				if(world.tick_usage > SS.tick_usage_max)
					sleep(TICK_LAG)
					continue
				try
					SS.on_life()
				catch(var/exception/e)
					log_error("[SS.name] on_life() error: [e] on [e.file]:[e.line]!<br>[e.desc]")
					sleep(10)
					continue
				sleep(TICKS_TO_DECISECONDS(SS.tick_rate))
			log_subsystem(SS.name,"Shutting down.")

	LOG_SERVER("Life complete.")

	/*
	spawn
		while(world_state != STATE_SHUTDOWN)
			for(var/subsystem/S in active_subsystems)
				try
					if(S.next_run <= ticks && S.next_run >= 0)
						var/start_life = world.timeofday
						if(!S.tick_rate || !S.on_life())
							active_subsystems -= S
							S.next_run = -1
						else
							S.next_run = ticks + S.tick_rate
						S.life_time = world.timeofday - start_life
				catch(var/exception/e)
					log_error("[S]: [e] on [e.file]:[e.line]!<br>[e.desc]")
					if(SHUTDOWN_SUBSYSTEM_ON_ERROR)
						active_subsystems -= S

			ticks += 1
			sleep(tick_lag)
		LOG_SERVER("ALL SUBSYSTEMS HAVE STOPPED.")
	*/
