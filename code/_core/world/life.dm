
/world/proc/life()
	set background = TRUE

	world.log << "STARTING WORLD."

	update_status()

	var/list/presorted_subsystems = list()

	for(var/S in subtypesof(/subsystem/))
		var/subsystem/new_subsystem = new S
		if(!new_subsystem.priority)
			world.log << "ERROR: COUNT NOT LOAD SUBSYSTEM [new_subsystem.name]."
			qdel(new_subsystem)
			continue

		presorted_subsystems[new_subsystem] = new_subsystem.priority

	ls_quicksort(presorted_subsystems)

	active_subsystems = new(length(presorted_subsystems))

	world.log << "[length(presorted_subsystems)] SUBSYSTEMS LOADED"

	var/index_tracker = 1
	for(var/subsystem/S in presorted_subsystems)
		active_subsystems[index_tracker] = S
		index_tracker += 1

	var/benchmark = world.timeofday

	for(var/subsystem/S in active_subsystems)
		var/local_benchmark = world.timeofday
		S.Initialize()
		world.log << "[S.name] Initialization: Took [DECISECONDS_TO_SECONDS((world.timeofday - local_benchmark))] seconds."

	world.log << "All initializations took [DECISECONDS_TO_SECONDS((world.timeofday - benchmark))] seconds."

	spawn while(TRUE)
		for(var/subsystem/S in active_subsystems)
			if(S.next_run <= ticks)
				if(!S.tick_rate || !S.on_life())
					active_subsystems -= S
					qdel(S)
					continue
				S.next_run = ticks + S.tick_rate

		curtime = round(curtime + TICK_LAG,TICK_LAG)
		ticks += 1
		tick_usage_average = (tick_usage_average+tick_usage)/2

		var/sleep_time = max(tick_lag,tick_usage*tick_lag*0.01)

		sleep(sleep_time)
