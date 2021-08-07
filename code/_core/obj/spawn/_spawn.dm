/obj/marker/mob_spawn/
	name = "mob spawn"

	var/mob/living/mob_type
	var/mob/living/mob_stored

	var/time_to_respawn
	var/time_of_death
	var/force_spawn

	invisibility = 101

	enable_chunk_clean = TRUE

/obj/marker/mob_spawn/New(var/desired_location,var/desired_mob_type,var/desired_mob_stored,var/desired_time_to_respawn,var/desired_force_spawn)
	. = ..()
	mob_type = desired_mob_type
	mob_stored = desired_mob_stored
	time_to_respawn = desired_time_to_respawn
	force_spawn = desired_force_spawn

/obj/marker/mob_spawn/proc/do_spawn(var/turf/T)
	var/mob/living/L = new mob_type(T)
	mob_stored = null
	INITIALIZE(L)
	GENERATE(L)
	FINALIZE(L)
	L.set_dir(dir)
	mob_stored = L
	return TRUE

/obj/marker/mob_spawn/on_chunk_clean()
	if(!mob_type)
		log_error("Warning: [src.get_debug_name()] has invalid spawning data.")
		qdel(src)
		return FALSE
	if(!mob_stored)
		do_spawn(loc)
		return TRUE
	var/mob/living/L = mob_stored
	if(L.dead || L.qdeleting)
		if(!time_of_death)
			time_of_death = world.time
		if(time_of_death + time_to_respawn <= world.time)
			time_of_death = null
			do_spawn(loc)
			return TRUE
	return FALSE