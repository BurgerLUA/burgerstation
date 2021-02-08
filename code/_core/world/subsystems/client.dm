SUBSYSTEM_DEF(client)
	name = "Client Subsystem"
	desc = "Controls how clients behave."
	tick_rate = CLIENT_TICK
	priority = SS_ORDER_PRELOAD

	var/advanced_ticks = 0

	cpu_usage_max = 0 //Uncapped.
	tick_usage_max = 0 //Uncapped.

	use_time_dialation = FALSE

/subsystem/client/on_life()

	advanced_ticks += 1

	var/do_slow = FALSE

	if(advanced_ticks >= CLIENT_TICKS_PER_SLOW_CLIENT_TICKS)
		do_slow = TRUE
		advanced_ticks = 0

	for(var/ckey in all_clients) //This should never be tick checked.
		var/client/C = all_clients[ckey]
		if(!C)
			log_error("Tried getting the client of [ckey] but it didn't exist!")
			all_clients -= ckey
			continue
		process_client(C,do_slow)


	return TRUE


/subsystem/client/proc/process_client(var/client/C,var/do_slow=FALSE)
	C.on_life()
	if(do_slow)
		C.on_life_slow()
	return TRUE