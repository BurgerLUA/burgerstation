SUBSYSTEM_DEF(spawning)
	name = "Spawning Subsystem"
	desc = "Controls the spawning of all mob-based spawnpoints on the map."
	priority = SS_ORDER_NORMAL
	tick_rate = SECONDS_TO_TICKS(30)
	var/list/obj/marker/mob_spawn/stored_spawns = list()

/subsystem/spawning/Initialize()

	for(var/mob/living/L in world)

		if(!L.respawn)
			continue

		var/turf/simulated/T = get_turf(L)
		if(!istype(T))
			log_error("Warning: [T] at ([T.x],[T.y],[T.z]) is not a simulated turf and has a mob spawnpoint on it.")
			continue

		var/obj/marker/mob_spawn/M = new(T,L.type,L,L.respawn_time,L.force_spawn)
		M.set_dir(L.random_spawn_dir ? pick(NORTH,EAST,SOUTH,WEST) : L.dir)
		stored_spawns += M

	return TRUE

/subsystem/spawning/on_life()

	for(var/k in stored_spawns)
		attempt_spawn(k)

	return TRUE

/subsystem/spawning/proc/attempt_spawn(var/obj/marker/mob_spawn/M)

	if(!M.mob_type)
		log_error("Warning: [M] at ([M.x],[M.y],[M.z]) has invalid spawning data.")
		stored_spawns -= M
		qdel(M)
		return FALSE

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

/subsystem/spawning/proc/do_spawn(var/obj/marker/mob_spawn/M)

	var/turf/spawning_turf = get_turf(M)

	if(!M.force_spawn)
		for(var/k in all_players)
			var/mob/living/advanced/player/P = k
			if(get_dist(M,P) <= VIEW_RANGE + ZOOM_RANGE)
				M.time_of_death = world.time
				return FALSE

	var/mob/living/L = new M.mob_type(spawning_turf)
	M.mob_stored = null
	INITIALIZE(L)
	GENERATE(L)
	FINALIZE(L)
	L.set_dir(M.dir)
	M.mob_stored = L

	return TRUE