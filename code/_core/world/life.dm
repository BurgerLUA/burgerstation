
/world/proc/life()
	set background = TRUE

	LOG_SERVER("STARTING WORLD.")

	update_status()

	world_state = STATE_INITIALIZING

	for(var/subsystem in subtypesof(/subsystem/))
		var/subsystem/S = new subsystem
		if(!S.priority)
			LOG_SERVER("ERROR: COUNT NOT LOAD SUBSYSTEM [S.name].")
			qdel(S)
			continue
		var/new_list = list()
		new_list["name"] = S.name
		new_list["priority"] = S.priority
		new_list["subsystem"] = S
		active_subsystems += list(new_list)

	active_subsystems = sortTim(active_subsystems, /proc/cmp_subsystem_priority)

	LOG_SERVER("[length(active_subsystems)] SUBSYSTEMS LOADED")

	var/benchmark = world.timeofday

	for(var/list/v in active_subsystems)
		var/local_benchmark = world.timeofday
		var/subsystem/S = v["subsystem"]
		S.Initialize()
		LOG_SERVER("[v["name"]] Initialization: Took [DECISECONDS_TO_SECONDS((world.timeofday - local_benchmark))] seconds.")

	LOG_SERVER("All initializations took [DECISECONDS_TO_SECONDS((world.timeofday - benchmark))] seconds.")

	world_state = STATE_RUNNING

	if(ENABLE_INSTALOAD)
		for(var/mob/abstract/observer/O in all_mobs_with_clients)
			if(!O.load_most_recent_character() && ENABLE_CHARGEN)
				O.new_character()

	else if(length(lobby_positions))
		for(var/mob/abstract/observer/O in all_mobs_with_clients)
			O.force_move(get_turf(pick(lobby_positions)))
			play_music_track("intro", O.client)

	spawn while(TRUE)
		for(var/list/v in active_subsystems)
			try
				var/subsystem/S = v["subsystem"]
				if(S.next_run <= ticks && S.next_run >= 0)
					if(!S.tick_rate || !S.on_life())
						active_subsystems -= list(v)
						S.next_run = -1
					else
						S.next_run = ticks + S.tick_rate
			catch(var/exception/e)
				LOG_ERROR("[v["name"]]: [e] on [e.file]:[e.line]!<br>[e.desc]")
				if(SHUTDOWN_SUBSYSTEM_ON_ERROR)
					active_subsystems -= list(v)

		curtime = round(curtime + TICK_LAG,TICK_LAG)
		ticks += 1
		sleep(TICK_LAG + lag_b_gone*0.1*TICK_LAG)