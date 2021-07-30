/event/horde
	name = "Horde"

	probability = 30 //relative

	occurances_max = 10

	var/chosen_horde_type //String
	var/mob/living/enemy_types_to_spawn

	var/obj/marker/spawnpoint/starting_marker
	var/obj/marker/spawnpoint/ending_marker

/event/horde/Destroy()
	starting_marker = null
	ending_marker = null
	return ..()

/event/horde/on_start()

	log_debug("Starting Horde Event")

	var/list/possible_horde_spawnpoints = list()

	for(var/k in horde_spawnpoints)
		var/obj/marker/spawnpoint/possible_marker = k
		var/turf/T = get_turf(possible_marker)
		if(!T.is_safe_teleport())
			continue

		var/player_close = FALSE
		for(var/p in all_players)
			var/mob/living/advanced/player/P = p
			if(get_dist(P,T) <= VIEW_RANGE + ZOOM_RANGE)
				player_close = TRUE
				break
		if(player_close)
			continue
		possible_horde_spawnpoints += possible_marker

	if(!length(possible_horde_spawnpoints))
		return FALSE

	starting_marker = pick(possible_horde_spawnpoints)
	ending_marker = pick(horde_spawnpoints - starting_marker)

	var/biome/B = SSbiome.chosen_biome
	chosen_horde_type = pickweight(B.horde_weights)
	if(!chosen_horde_type)
		return FALSE
	enemy_types_to_spawn = B.horde_types[chosen_horde_type]
	if(!length(enemy_types_to_spawn))
		return FALSE

	announce(
		"Central Command Enemy Report Division",
		"[capitalize(chosen_horde_type)] Patrol",
		"An enemy [capitalize(chosen_horde_type)] patrol has been detected near the area of operations on the surface level.",
		sound_to_play = 'sound/voice/announcement/horde.ogg'
	)

	var/spawn_amount = 2 + min(6,CEILING(length(all_players)*0.1,1))

	var/turf/T1 = get_turf(starting_marker)
	var/turf/T2 = get_turf(ending_marker)
	for(var/i=1,i<=spawn_amount,i++)
		CHECK_TICK(50,FPS_SERVER)
		var/mob/living/L = pick(enemy_types_to_spawn)
		L = new L(T1)
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)
		L.ai.set_active(TRUE)
		L.ai.set_path(T2)


	notify_ghosts("A new [chosen_horde_type] patrol is being created!",T1)

	. = ..()

/event/horde/on_end()
	log_debug("Ending Horde Event")
	. = ..()