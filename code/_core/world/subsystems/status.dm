var/global/list/all_living_with_status = list()

/subsystem/status/
	name = "Status Effect Subsystem"
	desc = "Controls the status effects of mobs."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT

/subsystem/status/on_life()

	for(var/mob/living/L in all_living_with_status)
		CHECK_TICK
		L.check_status_effects()
		L.handle_status_effects()

	return TRUE