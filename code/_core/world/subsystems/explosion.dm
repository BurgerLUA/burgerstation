var/global/list/active_explosions = list()

SUBSYSTEM_DEF(explosion)
	name = "Explosion Subsystem"
	desc = "Processes explosions."
	priority = SS_ORDER_NORMAL
	tick_rate = DECISECONDS_TO_TICKS(2)

/subsystem/explosion/on_life()

	for(var/explosion/E in active_explosions)
		E.process()

	return TRUE
