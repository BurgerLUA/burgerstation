/gamemode/horde/
	name = "Horde Mode (ERROR)"
	desc = "Fight off a near endless wave of enemies while attempting to complete objectives scattered across the map."

	var/list/horde_targets = list()

	var/list/tracked_enemies = list()

	var/total_killed_enemies = 0

	var/list/mob/living/enemy_types_to_spawn = list()

	hidden = TRUE

	var/enemies_to_spawn_base = 4
	var/enemies_to_spawn_per_player = 1
	var/enemies_to_spawn_per_minute = 0.34

/gamemode/horde/update_objectives()

	. = ..()

	if(!length(active_objectives) && length(completed_objectives) >= 1 && state == GAMEMODE_FIGHTING)
		state = GAMEMODE_BREAK
		if(can_continue())
			SSvote.create_vote(/vote/continue_round)
		else
			world.end(WORLD_END_NANOTRASEN_VICTORY)

	return .

/gamemode/horde/New()

	state = GAMEMODE_WAITING
	round_time = 0
	round_time_next = HORDE_DELAY_WAIT //Skip to gearing. Nothing to wait for.
	announce(name,"Starting new round...",desc)

	for(var/k in horde_spawnpoints)
		var/turf/T = k
		var/mob/living/L = pickweight(enemy_types_to_spawn)
		L = new L(T)
		INITIALIZE(L)
		FINALIZE(L)

	for(var/obj/structure/interactive/computer/console/remote_flight/O in world)
		if(O.z < Z_LEVEL_MISSION)
			continue
		horde_targets += O

	return ..()

/gamemode/horde/can_continue()

	if(length(SSbosses.living_bosses) <= 0)
		return FALSE

	return ..()

/gamemode/horde/proc/add_objectives()

	var/player_count = length(all_clients)

	LOG_DEBUG("Current player count: [player_count].")

	//Base Objectives.
	add_objective(/objective/artifact)
	add_objective(/objective/hostage)

	if(player_count >= 10)
		add_objective(/objective/hostage)
		LOG_DEBUG("Adding player count 10 objectives.")

	if(player_count >= 20)
		add_objective(/objective/kill_boss)
		LOG_DEBUG("Adding player count 20 objectives.")

	if(player_count >= 30)
		add_objective(/objective/kill_boss)
		LOG_DEBUG("Adding player count 30 objectives.")

	if(player_count >= 40)
		add_objective(/objective/kill_boss)
		LOG_DEBUG("Adding player count 40 objectives.")

	next_objective_update = world.time + 100

	return TRUE

/gamemode/horde/on_continue()

	if(!add_objective(/objective/kill_boss))
		state = GAMEMODE_BREAK
		SSvote.create_vote(/vote/continue_round)
	else
		add_objective(/objective/artifact)

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
	announce("Central Command Update","Prepare for Landfall","All landfall are ordered to gear up for planetside combat. Estimated time until shuttle functionality: [CEILING(HORDE_DELAY_GEARING/60,1)] minutes. Objectives will be announced soon.",ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')
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
	announce("Central Command Update","Shuttle Boarding","All landfall crew are ordered to proceed to the hanger bay and prep for shuttle launch. Shuttles will be allowed to launch in [CEILING(HORDE_DELAY_BOARDING/60,1)] minutes.",ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')
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
	announce("Central Command Update","Mission is a Go","Shuttles are prepped and ready to depart into Syndicate territory. Launch now.",ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')
	allow_launch = TRUE
	return TRUE

/gamemode/horde/proc/on_launching()
	var/time_to_display = round_time_next - round_time
	set_status_display("mission","LNCH\n[get_clock_time(time_to_display)]")
	if(time_to_display >= 0)
		set_message("Launch Period: [get_clock_time(time_to_display)]",TRUE)
		return TRUE
	state = GAMEMODE_FIGHTING
	round_time = 0
	announce("Central Command Update","Incoming Syndicate Forces","Enemy forces spotted heading towards the Bravo landing zone. Prepare for enemy combatants.",ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')
	return TRUE


/gamemode/horde/proc/on_fighting()

	var/wave_to_spawn = get_enemies_to_spawn()

	if(wave_to_spawn < 4)
		return TRUE

	wave_to_spawn = 4 //Only spawn 4 in a group at a time.

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

	var/turf/T = get_turf(spawn_node)

	while(wave_to_spawn > 0)
		wave_to_spawn--
		CHECK_TICK(50,FPS_SERVER*5)
		var/mob/living/L = pickweight(enemy_types_to_spawn)
		L = new L(T)
		INITIALIZE(L)
		FINALIZE(L)
		L.ai.set_path(found_path)
		tracked_enemies += L
		HOOK_ADD("post_death","horde_post_death",L,src,.proc/on_killed_enemy)

/gamemode/horde/proc/on_killed_enemy(var/mob/living/L,var/args)

	if(!(L in tracked_enemies))
		return FALSE

	total_killed_enemies++
	tracked_enemies -= L

	return TRUE

/gamemode/horde/proc/get_enemies_to_spawn()
	return CEILING(clamp(enemies_to_spawn_base + length(all_players)*enemies_to_spawn_per_player + FLOOR(DECISECONDS_TO_SECONDS(world.time)/(60*enemies_to_spawn_per_minute),1),0,40),4) - length(tracked_enemies) //One additional enemy every 3 minutes.

/gamemode/horde/proc/find_horde_target()

	var/picks_remaining = 3

	while(picks_remaining > 0)
		picks_remaining--
		CHECK_TICK(50,FPS_SERVER*10)
		var/turf/chosen_target = get_turf(pick(horde_targets))
		if(chosen_target.z < Z_LEVEL_MISSION)
			continue
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
		if(chosen_spawn.z < Z_LEVEL_MISSION) continue
		var/found_player = FALSE
		for(var/k in all_players)
			CHECK_TICK(50,FPS_SERVER*20)
			var/mob/living/advanced/player/P = k
			if(P && !P.dead) continue
			if(get_dist(P,chosen_spawn) <= VIEW_RANGE + ZOOM_RANGE)
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