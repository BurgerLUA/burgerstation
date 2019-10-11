/subsystem/spawning/
	name = "Spawning Subsystem"
	desc = "Controls the spawning of all mob-based spawnpoints on the map."
	priority = SS_ORDER_SPAWNING
	tick_rate = SECONDS_TO_TICKS(10)
	var/list/turf/simulated/stored_turfs = list()

/subsystem/spawning/Initialize()

	for(var/mob/living/L in world)
		if(!L.respawn)
			continue
		var/turf/simulated/T = get_turf(L)
		if(!istype(T))
			LOG_ERROR("Warning: [T] at ([T.x],[T.y],[T.z]) is not a simulated turf and has a mob spawnpoint on it.")
			continue
		if(length(T.spawning_data))
			LOG_ERROR("Warning: [T] at ([T.x],[T.y],[T.z]) has more than one mob on it.")
			continue
		T.spawning_data = list()
		T.spawning_data["mob_type"] = L.type
		T.spawning_data["mob_stored"] = L
		T.spawning_data["time_to_respawn"] = L.respawn_time
		T.spawning_data["time_of_death"] = 0
		T.spawning_data["mob_dir"] = L.random_spawn_dir ? pick(NORTH,EAST,SOUTH,WEST) : L.dir
		T.spawning_data["level_multiplier"] = L.level_multiplier
		stored_turfs += T

	return TRUE

/subsystem/spawning/on_life()
	for(var/turf/simulated/T in stored_turfs)
		attempt_spawn(T)

	return TRUE

/subsystem/spawning/proc/attempt_spawn(var/turf/simulated/T)

	if(!T.spawning_data["mob_type"])
		LOG_ERROR("Warning: [T] at ([T.x],[T.y],[T.z]) has invalid spawning data.")
		return

	if(!T.spawning_data["mob_stored"])
		return do_spawn(T)

	var/mob/living/L = T.spawning_data["mob_stored"]
	if( (L.status & FLAG_STATUS_DEAD) || L.qdeleting)
		if(!T.spawning_data["time_of_death"])
			T.spawning_data["time_of_death"] = curtime

		if(T.spawning_data["time_of_death"] + T.spawning_data["time_to_respawn"] <= curtime)
			T.spawning_data["time_of_death"] = 0
			return do_spawn(T)

	return FALSE

/subsystem/spawning/proc/do_spawn(var/turf/simulated/T)

	var/area/A = get_area(T)
	T.spawning_data["mob_stored"] = null
	var/path = T.spawning_data["mob_type"]
	var/mob/living/L = new path(T,desired_level_multiplier = T.spawning_data["level_multiplier"] + A.level_multiplier)
	L.set_dir(T.spawning_data["mob_dir"])
	if(!L.initialized)
		L.Initialize()
	T.spawning_data["mob_stored"] = L

	return TRUE