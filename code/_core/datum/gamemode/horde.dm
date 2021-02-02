/gamemode/horde/
	name = "Horde Mode (ERROR)"
	desc = "Fight off a near endless wave of enemies while attempting to complete objectives scattered across the map."

	var/list/horde_targets = list()

	var/list/tracked_enemies = list()

	var/total_killed_enemies = 0

	var/list/mob/living/enemy_types_to_spawn = list()

	hidden = TRUE

	var/enemies_to_spawn_base = 4
	var/enemies_to_spawn_per_player = 0.5
	var/enemies_to_spawn_per_minute = 0.1

	var/next_spawn_check = 0

	var/spawn_on_markers = TRUE

	var/atom/list/priority_targets  = list()

/gamemode/horde/update_objectives()

	. = ..()

	if(!length(crew_active_objectives) && length(crew_completed_objectives) >= 1 && state == GAMEMODE_FIGHTING)
		state = GAMEMODE_BREAK
		if(can_continue())
			SSvote.create_vote(/vote/continue_round)
		else
			world.end(WORLD_END_NANOTRASEN_VICTORY)

	return .

/gamemode/horde/proc/create_horde_mob(var/desired_loc)
	var/mob/living/L = pickweight(enemy_types_to_spawn)
	L = new L(desired_loc)
	INITIALIZE(L)
	FINALIZE(L)
	GENERATE(L)
	HOOK_ADD("post_death","horde_post_death",L,src,.proc/on_killed_enemy)
	return L

/gamemode/horde/New()

	state = GAMEMODE_WAITING
	round_time = 0
	round_time_next = HORDE_DELAY_WAIT //Skip to gearing. Nothing to wait for.
	announce(name,"Starting new round...",desc)

	if(spawn_on_markers)
		for(var/k in horde_spawnpoints)
			var/turf/T = k
			create_horde_mob(T)

	for(var/obj/structure/interactive/computer/console/remote_flight/O in world)
		if(O.z != Z_LEVEL_MISSION)
			continue
		horde_targets += O

	return ..()

/gamemode/horde/can_continue()

	if(length(SSbosses.living_bosses) <= 0)
		return FALSE

	return ..()

/gamemode/horde/proc/add_objectives()

	var/player_count = length(all_clients)

	log_debug("Current player count: [player_count].")

	//Base Objectives.
	add_objective(/objective/artifact)
	add_objective(/objective/hostage)
	add_objective(/objective/defense)

	if(player_count >= 10)
		add_objective(/objective/hostage)
		log_debug("Adding player count 10 objectives.")

	if(player_count >= 20)
		add_objective(/objective/kill_boss)
		log_debug("Adding player count 20 objectives.")

	if(player_count >= 30)
		add_objective(/objective/kill_boss)
		log_debug("Adding player count 30 objectives.")

	if(player_count >= 40)
		add_objective(/objective/kill_boss)
		log_debug("Adding player count 40 objectives.")

	next_objective_update = world.time + 100

	return TRUE

/gamemode/horde/on_continue()

	if(!add_objective(/objective/kill_boss))
		state = GAMEMODE_BREAK
		SSvote.create_vote(/vote/continue_round)
	else
		add_objective(/objective/artifact)

	points += 20

	return ..()

/gamemode/horde/on_life()

	switch(state)
		if(GAMEMODE_WAITING)
			on_waiting()
		if(GAMEMODE_GEARING)
			on_gearing()
		if(GAMEMODE_BOARDING)
			on_boarding()
		if(GAMEMODE_LAUNCHING)
			on_launching()
		if(GAMEMODE_FIGHTING)
			points -= FLOOR(1/60,0.01)
			on_fighting()

	return ..()

/gamemode/horde/proc/on_waiting()
	var/time_to_display = round_time_next - round_time
	set_status_display("mission","PREP\n[get_clock_time(time_to_display)]")
	if(time_to_display >= 0)
		set_message("Round starts in: [get_clock_time(time_to_display)]",TRUE)
		return TRUE
	state = GAMEMODE_GEARING
	round_time = 0
	round_time_next = HORDE_DELAY_GEARING
	SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(60*10 + 10)
	announce(
		"Central Command Update",
		"Prepare for Landfall",
		"All landfall crew are ordered to gear up for planetside combat. Estimated time until shuttle and drop pod functionality: 10 minutes.",
		ANNOUNCEMENT_STATION,
		'sound/voice/announcement/landfall_crew_8_minutes.ogg'
	)
	add_objectives()
	return TRUE

/gamemode/horde/proc/on_gearing()
	var/time_to_display = round_time_next - round_time
	set_status_display("mission","GEAR\n[get_clock_time(time_to_display)]")
	if(time_to_display >= 0)
		set_message("Loadout Period: [get_clock_time(time_to_display)]",TRUE)
		return TRUE
	state = GAMEMODE_BOARDING
	round_time = 0
	round_time_next = HORDE_DELAY_BOARDING
	announce(
		"Central Command Update",
		"Shuttle Boarding",
		"All landfall crew are ordered to proceed to the hanger bay and prep for shuttle launch. Shuttles will be allowed to launch in 2 minutes.",
		ANNOUNCEMENT_STATION,
		'sound/voice/announcement/landfall_crew_2_minutes.ogg'
	)
	return TRUE

/gamemode/horde/proc/on_boarding()
	var/time_to_display = round_time_next - round_time
	set_status_display("mission","BRDN\n[get_clock_time(time_to_display)]")
	if(time_to_display >= 0)
		set_message("Boarding Period: [get_clock_time(time_to_display)]",TRUE)
		return TRUE
	state = GAMEMODE_LAUNCHING
	round_time = 0
	round_time_next = HORDE_DELAY_LAUNCHING
	announce("Central Command Mission Update","Mission is a Go","Shuttles are prepped and ready to depart into the Area of Operations. All crew are cleared to launch.",ANNOUNCEMENT_STATION,'sound/voice/announcement/landfall_crew_0_minutes.ogg')
	allow_launch = TRUE
	SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(10)
	return TRUE

/gamemode/horde/proc/on_launching()
	var/time_to_display = round_time_next - round_time
	set_status_display("mission","LNCH\n[get_clock_time(time_to_display)]")
	if(time_to_display >= 0)
		set_message("Launch Period: [get_clock_time(time_to_display)]",TRUE)
		return TRUE
	state = GAMEMODE_FIGHTING
	round_time = 0
	for(var/k in all_fog)
		var/obj/effect/fog_of_war/F = k
		F.remove()
	for(var/objective/O in crew_active_objectives)
		O.on_gamemode_playable()
	return TRUE

/gamemode/horde/proc/on_fighting()

	if(next_spawn_check > world.time)
		return TRUE

	next_spawn_check = world.time + SECONDS_TO_DECISECONDS(1) //Incase a check fails.

	handle_alert_level()

	var/wave_to_spawn = get_enemies_to_spawn() - length(tracked_enemies)

	var/wave_we_want_to_spawn = get_wave_size()

	if(wave_to_spawn < wave_we_want_to_spawn)
		return TRUE

	wave_to_spawn = wave_we_want_to_spawn //Only spawn 4 in a group at a time.

	var/obj/marker/map_node/spawn_node = find_horde_spawn()
	if(!spawn_node)
		log_error("ERROR: Could not find a valid horde spawn!")
		return TRUE

	var/obj/marker/map_node/target_node = find_horde_target()
	if(!target_node)
		log_error("ERROR: Could not find a valid horde target!")
		return TRUE

	var/obj/marker/map_node/list/found_path = spawn_node.find_path(target_node)
	if(!found_path)
		log_error("ERROR: Could not find a valid path from [spawn_node.get_debug_name()] to [target_node.get_debug_name()]!")
		return TRUE

	next_spawn_check = world.time + get_wave_frequency()

	var/turf/T = get_turf(spawn_node)
	while(wave_to_spawn > 0)
		wave_to_spawn--
		CHECK_TICK(50,FPS_SERVER*5)
		var/mob/living/L = create_horde_mob(T)
		L.ai.set_path(found_path)
		for(var/k in priority_targets)
			L.ai.obstacles[k] = TRUE
		tracked_enemies += L
		points -= 0.1

	for(var/k in tracked_enemies)
		var/mob/living/L = k
		if(!istype(L) || L.dead || L.qdeleting) //TODO: Remove these checks
			log_error("Warning: [k] was invalid tracked enemy!")
			tracked_enemies -= k
			continue
		if(L.ai && !L.ai.current_path)
			L.ai.set_path(found_path)

/gamemode/horde/proc/get_wave_frequency()

	var/player_count = length(all_clients)

	switch(player_count)
		if(0 to 10)
			return SECONDS_TO_DECISECONDS(60)
		if(10 to 20)
			return SECONDS_TO_DECISECONDS(45)
		if(20 to 30)
			return SECONDS_TO_DECISECONDS(30)
		if(30 to INFINITY)
			return SECONDS_TO_DECISECONDS(15)

	return SECONDS_TO_DECISECONDS(60)

/gamemode/horde/proc/get_wave_size()

	var/player_count = length(all_clients)

	switch(player_count)
		if(0 to 10)
			return 3
		if(10 to 20)
			return 4
		if(20 to 30)
			return 5
		if(30 to INFINITY)
			return 6

	return 4



/gamemode/horde/proc/get_enemy_types_to_spawn()
	return enemy_types_to_spawn

/gamemode/horde/proc/on_killed_enemy(var/mob/living/L,var/args)

	for(var/k in SSholiday.holidays)
		var/holiday/H = SSholiday.holidays[k]
		H.horde_post_death(L)

	if(!(L in tracked_enemies))
		return FALSE

	total_killed_enemies++
	tracked_enemies -= L

	points += 0.1

	return TRUE

/gamemode/horde/proc/get_enemies_to_spawn()
	. = enemies_to_spawn_base
	if(enemies_to_spawn_per_player)
		. += min(30,length(all_players))*enemies_to_spawn_per_player
	if(enemies_to_spawn_per_minute)
		. += DECISECONDS_TO_SECONDS(world.time)/(60*enemies_to_spawn_per_minute)
	. = min(.,50)
	return FLOOR(.,1)

/gamemode/horde/proc/find_horde_target()

	var/picks_remaining = 3

	for(var/k in priority_targets)
		var/atom/A = k
		if(A.qdeleting)
			priority_targets -= k

	while(picks_remaining > 0)
		picks_remaining--
		CHECK_TICK(50,FPS_SERVER*10)
		var/turf/chosen_target

		if(length(priority_targets))
			chosen_target = get_turf(pick(priority_targets))
			if(chosen_target.z != Z_LEVEL_MISSION)
				continue
		else if(length(horde_targets))
			chosen_target = get_turf(pick(horde_targets))
			if(chosen_target.z != Z_LEVEL_MISSION)
				continue
		else
			return null

		var/obj/marker/map_node/N_end = find_closest_node(get_turf(chosen_target))
		if(!N_end)
			continue
		return N_end

	return null

/gamemode/horde/proc/find_horde_spawn()

	var/picks_remaining = 3

	while(picks_remaining > 0)
		picks_remaining--
		CHECK_TICK(50,FPS_SERVER*20)
		var/turf/chosen_spawn = pick(all_syndicate_spawns)
		var/found_player = FALSE
		for(var/k in all_players)
			CHECK_TICK(50,FPS_SERVER*20)
			var/mob/living/advanced/player/P = k
			if(P && P.dead) continue //They're dead. Doesn't matter.
			if(get_dist(P,chosen_spawn) > VIEW_RANGE + ZOOM_RANGE) continue //They're close, doesn't matter.
			found_player = TRUE
			break
		if(found_player)
			continue
		var/obj/marker/map_node/N_start = find_closest_node(get_turf(chosen_spawn))
		if(!N_start)
			log_error("WARNING: [chosen_spawn.get_debug_name()] didn't have a node to spawn enemies!")
			continue
		return N_start

	return null