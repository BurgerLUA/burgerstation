/datum/subsystem/spawnpoints/
	name = "Spawnpoint Subsystem"
	desc = "Controls the spawning of all mob-based spawnpoints on the map."
	priority = SS_ORDER_SPAWNPOINTS
	tick_rate = SECONDS_TO_TICKS(60)

/datum/subsystem/spawnpoints/on_life()
	for(var/v in mob_spawnpoints)
		var/obj/marker/spawnpoint/mob/S = v
		S.trigger_spawn()

	return TRUE
