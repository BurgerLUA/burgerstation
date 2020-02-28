SUBSYSTEM_DEF(spawning)
	name = "Spawning Subsystem"
	desc = "Controls the spawning of all mob-based spawnpoints on the map."
	priority = SS_ORDER_SPAWNING
	tick_rate = SECONDS_TO_TICKS(10)
	var/list/obj/mob_spawn/stored_spawns = list()

/subsystem/spawning/Initialize()

	if(!ENABLE_MOB)
		return TRUE

	for(var/mob/living/L in world)

		if(!L.respawn)
			continue

		var/turf/simulated/T = get_turf(L)

		if(!isturf(T))
			LOG_ERROR("Warning: [T] at ([T.x],[T.y],[T.z]) is not a simulated turf and has a mob spawnpoint on it.")
			continue

		var/obj/mob_spawn/M = new(T,L.type,L,L.respawn_time,L.level_multiplier,L.force_spawn)
		M.set_dir(L.random_spawn_dir ? pick(NORTH,EAST,SOUTH,WEST) : L.dir)

		stored_spawns += M

	return TRUE

/subsystem/spawning/on_life()

	if(!ENABLE_MOB)
		return TRUE

	for(var/obj/mob_spawn/M in stored_spawns)
		attempt_spawn(M)

	return TRUE

/subsystem/spawning/proc/attempt_spawn(var/obj/mob_spawn/M)

	if(!M.mob_type)
		LOG_ERROR("Warning: [M] at ([M.x],[M.y],[M.z]) has invalid spawning data.")
		return

	if(!M.mob_stored)
		return do_spawn(M)

	var/mob/living/L = M.mob_stored
	if( L.dead || L.qdeleting)
		if(!M.time_of_death)
			M.time_of_death = world.time

		if(M.time_of_death + M.time_to_respawn <= world.time)
			M.time_of_death = null
			return do_spawn(M)

	return FALSE

/subsystem/spawning/proc/do_spawn(var/obj/mob_spawn/M)

	var/turf/spawning_turf = get_turf(M)

	if(!M.force_spawn)
		for(var/mob/living/advanced/player/P in range(spawning_turf,VIEW_RANGE))
			if(P && is_valid(P))
				M.time_of_death = world.time
				return FALSE

	var/path = M.mob_type
	var/area/A = get_area(M)
	M.mob_stored = null

	var/mob/living/L = new path(spawning_turf,desired_level_multiplier = M.level_multiplier + A.level_multiplier)
	L.set_dir(M.dir)

	if(!L.initialized)
		L.Initialize()

	M.mob_stored = L

	return TRUE