
/world/proc/life()
	set background = TRUE

	world.log << "STARTING WORLD."

	update_status()

	for(var/subsystem in subtypesof(/subsystem/))
		var/subsystem/S = new subsystem
		if(!S.priority)
			world.log << "ERROR: COUNT NOT LOAD SUBSYSTEM [S.name]."
			qdel(S)
			continue
		var/new_list = list()
		new_list["name"] = S.name
		new_list["priority"] = S.priority
		new_list["subsystem"] = S
		active_subsystems += list(new_list)

	active_subsystems = sortByKey(active_subsystems,"priority")

	world.log << "[length(active_subsystems)] SUBSYSTEMS LOADED"
	world.log << "FIRST: [active_subsystems[1]["name"]]"
	world.log << "LAST: [active_subsystems[length(active_subsystems)]["name"]]"

	var/benchmark = world.timeofday

	for(var/list/v in active_subsystems)
		var/local_benchmark = world.timeofday
		var/subsystem/S = v["subsystem"]
		S.Initialize()
		world.log << "[v["name"]] Initialization: Took [DECISECONDS_TO_SECONDS((world.timeofday - local_benchmark))] seconds."

	world.log << "All initializations took [DECISECONDS_TO_SECONDS((world.timeofday - benchmark))] seconds."

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
