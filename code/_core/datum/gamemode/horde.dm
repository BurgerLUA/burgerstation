/gamemode/horde/
	name = "Free-Roam Horde"
	desc = "Fight off a near endless wave of enemies while attempting to complete objectives scattered across the map."

	var/list/horde_targets = list()

	var/list/tracked_enemies = list()

	var/total_killed_enemies = 0

/gamemode/horde/New()
	state = GAMEMODE_WAITING
	round_time = 0
	round_time_next = 1 //Skip to gearing. Nothing to wait for.
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
	announce("Central Command Update","Prepare for Landfall","All landfall are ordered to gear up for planetside combat. Estimated time until shuttle functionality: [CEILING(HORDE_DELAY_GEARING/60,1)] minutes.",ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')
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
	announce("Central Command Update","Shuttle Boarding","All landfall crew are ordered to proceed to the hanger bay and prep for shuttle launch. Shuttles will be allowed to launch in [CEILING(HORDE_DELAY_BOARDING/60,1)] minutes. Objectives will be announced soon.",ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')
	next_objective_update = world.time + 100
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
	for(var/obj/shuttle_controller/S in all_shuttle_controlers)
		allowed_shuttles += S
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
		var/mob/living/advanced/npc/syndicate/S = new(T)
		INITIALIZE(S)
		S.ai.set_path(found_path)
		tracked_enemies += S


/gamemode/horde/proc/on_killed_enemy(var/mob/living/L)

	if(!(L in tracked_enemies))
		return FALSE

	total_killed_enemies++
	tracked_enemies -= L

	return TRUE

/gamemode/horde/proc/get_enemies_to_spawn()
	return clamp(10 + FLOOR(DECISECONDS_TO_SECONDS(world.time)/300,1),0,40) - length(tracked_enemies) //One additional enemy every 5 minutes.

/gamemode/horde/proc/find_horde_target()

	var/picks_remaining = 4

	while(picks_remaining > 0)
		CHECK_TICK(50,FPS_SERVER*10)
		picks_remaining--
		var/turf/chosen_target = get_turf(pick(horde_targets))
		if(chosen_target.z != 3)
			continue
		var/obj/marker/map_node/N_end = find_closest_node(get_turf(chosen_target))
		if(!N_end)
			continue
		return N_end

	return null


/gamemode/horde/proc/find_horde_spawn()

	var/picks_remaining = 4

	while(picks_remaining > 0)
		CHECK_TICK(50,FPS_SERVER*10)
		picks_remaining--
		var/turf/chosen_spawn = pick(all_syndicate_spawns)
		if(chosen_spawn.z != 3)
			continue
		var/mob/living/advanced/player/P = locate() in range(VIEW_RANGE + ZOOM_RANGE,chosen_spawn)
		if(P)
			continue
		var/obj/marker/map_node/N_start = find_closest_node(get_turf(chosen_spawn))
		if(!N_start)
			log_error("WARNING: [chosen_spawn.get_debug_name()] didn't have a node to spawn enemies!")
			continue
		return N_start

	return null