
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

	active_subsystems = sortByKey(active_subsystems,"priority")

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
			O.load_most_recent_character()

	spawn while(TRUE)
		for(var/list/v in active_subsystems)
			var/subsystem/S = v["subsystem"]
			if(S.next_run <= ticks)
				if(!S.tick_rate || !S.on_life())
					active_subsystems -= v
					qdel(S)
					continue
				S.next_run = ticks + S.tick_rate

		curtime = round(curtime + TICK_LAG,TICK_LAG)
		ticks += 1
		sleep(tick_lag)