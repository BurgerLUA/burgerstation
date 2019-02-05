/subsystem/lighting/
	name = "Lighting Subsystem"
	desc = "Controls the lighting."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_LIGHTING

/subsystem/lighting/on_life()
	for(var/client/C in all_clients)
		C.update_lighting()

	return TRUE