/event/horde
	name = "Horde"

	probability = 10 //relative

	occurances_max = 10

	var/chosen_horde_type //String
	var/mob/living/enemy_types_to_spawn

	var/obj/marker/spawnpoint/starting_marker
	var/obj/marker/spawnpoint/ending_marker

	minor_event = TRUE

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

	var/spawn_amount = 2 + min(6,CEILING(length(all_players)*0.1,1))

	var/turf/T1 = get_turf(starting_marker)
	var/turf/T2 = get_turf(ending_marker)

	var/obj/marker/map_node/N_start = find_closest_node(T1)
	var/obj/marker/map_node/N_end = N_start ? find_closest_node(T2) : null
	var/list/obj/marker/map_node/found_path = N_end ? N_start.find_path(N_end) : null

	if(!found_path)
		log_error("ERROR: Could not find proper path from [T1.get_debug_name()] to [T2.get_debug_name()].")
		return FALSE

	var/list/possible_turfs = list()
	for(var/turf/simulated/floor/T in view(VIEW_RANGE,T1))
		if(!T.is_safe_teleport())
			continue
		possible_turfs += T

	if(!length(possible_turfs))
		log_error("ERROR: Could not find a proper place to spawn horde mobs!")
		return FALSE

	for(var/i=1,i<=spawn_amount,i++)
		CHECK_TICK(50,FPS_SERVER)
		var/mob/living/L = pick(enemy_types_to_spawn)
		var/turf/chosen_turf = pick(possible_turfs)
		possible_turfs -= chosen_turf
		L = new L(chosen_turf)
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)
		L.ai.set_path(found_path)
		if(length(possible_turfs) <= 0)
			break

	notify_ghosts("A new [chosen_horde_type] patrol is being created!",T1)

	. = ..()

/event/horde/on_end()
	log_debug("Ending Horde Event")
	. = ..()