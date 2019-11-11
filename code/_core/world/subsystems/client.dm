/subsystem/client/
	name = "Client Subsystem"
	desc = "Controls how clients behave."
	tick_rate = 1
	priority = SS_ORDER_PRELOAD

/subsystem/client/on_life()

	set background = TRUE

	for(var/client/C in all_clients)
		C.on_life()

	for(var/mob/living/advanced/player/debug/D in all_mobs)
		D.on_life_client()

	return TRUE