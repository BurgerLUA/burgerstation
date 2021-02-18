SUBSYSTEM_DEF(explosion)
	name = "Explosion Subsystem"
	desc = "Processes explosions."
	priority = SS_ORDER_NORMAL
	tick_rate = DECISECONDS_TO_TICKS(1)

	var/list/obj/explosion_process/active_explosions = list()

/subsystem/explosion/on_life()

	for(var/k in active_explosions)
		var/obj/explosion_process/EP = k
		EP.process()

	return TRUE
