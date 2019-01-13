/datum/subsystem/spawnpoints/
	name = "Spawnpoint Subsystem"
	desc = "Controls the spawning of all mob-based spawnpoints on the map."
	priority = SS_ORDER_SPAWNPOINTS
	tick_rate = 600 //60 seconds

/datum/subsystem/spawnpoints/on_life()
	for(var/v in mob_spawnpoints)
		var/obj/marker/spawnpoint/mob/S = v
		S.trigger_spawn()

	return TRUE
