SUBSYSTEM_DEF(client)
	name = "Client Subsystem"
	desc = "Controls how clients behave."
	tick_rate = CLIENT_TICK
	priority = SS_ORDER_PRELOAD

	var/advanced_ticks = 0

	cpu_usage_max = 100
	tick_usage_max = 100

/subsystem/client/on_life()

	var/do_slow = advanced_ticks >= CLIENT_TICKS_PER_SLOW_CLIENT_TICKS

	for(var/ckey in all_clients)
		var/client/C = all_clients[ckey]
		CHECK_TICK
		C.on_life()
		if(do_slow)
			C.on_life_slow()

	if(do_slow)
		advanced_ticks = 0
	else
		advanced_ticks += 1

	return TRUE