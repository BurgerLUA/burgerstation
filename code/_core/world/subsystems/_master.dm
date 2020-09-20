//WIP

SUBSYSTEM_DEF(master)
	name = "Master Subsystem"
	desc = "Handles how fast subsystems run, dynamically."
	priority = 0

	var/list/subsystem_ticks = list()

/subsystem/master/proc/default()
	subsystem_ticks["client"] = 2
	subsystem_ticks["client_slow"] = FPS_SERVER
	subsystem_ticks["life"] = DECISECONDS_TO_TICKS(4)
	subsystem_ticks["life_slow"] = DECISECONDS_TO_TICKS(8)
	subsystem_ticks["ai"] = DECISECONDS_TO_TICKS(2)
	subsystem_ticks["boss"] = DECISECONDS_TO_TICKS(2)
	subsystem_ticks["projectile"] = DECISECONDS_TO_TICKS(2)

/subsystem/master/Initialize()

	return ..()