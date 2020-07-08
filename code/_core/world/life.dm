
/world/proc/life()
	//set background = TRUE

	LOG_SERVER("STARTING WORLD.")

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

	for(var/subsystem/SS in active_subsystems)
		var/local_benchmark = world.timeofday
		log_subsystem(SS.name,"Initializing...")
		INITIALIZE(SS)
		log_subsystem(SS.name,"Initialization took [DECISECONDS_TO_SECONDS((world.timeofday - local_benchmark))] seconds.")

	log_subsystem("Subsystem Controller","[length(active_subsystems)] subsystems initialized.")

	log_subsystem("Subsystem Controller","All initializations took [DECISECONDS_TO_SECONDS((world.timeofday - benchmark))] seconds.")

	for(var/subsystem/SS in active_subsystems)
		spawn
			while(SS.tick_rate > 0 && world_state != STATE_SHUTDOWN)
				if(SS.overtime_count < SS.overtime_max)
					if(world.cpu > SS.cpu_usage_max)
						SS.overtime_count++
						sleep(TICK_LAG)
						continue
					if(world.tick_usage > SS.tick_usage_max)
						SS.overtime_count++
						sleep(TICK_LAG)
						continue
				try
					SS.overtime_count = 0
					var/pre_usage_tick = world.tick_usage
					var/pre_usage_cpu = world.cpu
					SS.on_life()
					SS.last_usage_cpu = world.cpu - pre_usage_cpu
					SS.last_usage_tick = world.tick_usage - pre_usage_tick
				catch(var/exception/e)
					log_error("[SS.name] on_life() error: [e] on [e.file]:[e.line]!<br>[e.desc]")
					sleep(10)
					continue
				sleep(TICKS_TO_DECISECONDS(SS.tick_rate))
			log_subsystem(SS.name,"Shutting down.")

	world_state = STATE_RUNNING

	if(ENABLE_INSTALOAD)
		for(var/mob/abstract/observer/menu/O in all_mobs_with_clients)
			if(!O.load_most_recent_character())
				O.new_character()

	else if(length(lobby_positions))
		for(var/mob/abstract/observer/menu/O in all_mobs_with_clients)
			O.force_move(get_turf(pick(lobby_positions)))
			play_music_track("slow_fall", O.client)
			O.show_hud(TRUE,speed = 2)

	log_subsystem("Subsystem Controller","Life initializations complete.")

	update_server_status()

	return TRUE