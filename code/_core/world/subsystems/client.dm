/subsystem/client/
	name = "Client Subsystem"
	desc = "Controls how clients behave."
	tick_rate = CLIENT_TICK
	priority = SS_ORDER_PRELOAD

	var/advanced_ticks = 0

/subsystem/client/on_life()

	var/do_slow = advanced_ticks >= CLIENT_TICKS_PER_SLOW_CLIENT_TICKS

	for(var/client/C in all_clients)
		CHECK_TICK
		C.on_life()
		if(do_slow)
			C.on_life_slow()

	if(do_slow)
		advanced_ticks = 0
	else
		advanced_ticks += 1

	return TRUE