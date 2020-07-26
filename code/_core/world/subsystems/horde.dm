//Here be shitcode.
//I need to improve this in the future.

SUBSYSTEM_DEF(horde)
	name = "Horde Subsystem"
	desc = "Handles hordes and whatnot."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(1)
	var/round_time = 0 //In seconds.
	var/round_time_next = 0 //In seconds.
	var/state = HORDE_STATE_PRELOAD

	var/list/tracked_enemies = list()

	var/message_displayed = FALSE

	var/list/possible_horde_targets = list()

	var/total_killed_syndicate = 0

	var/next_hijack_check_time = 0

	var/allow_shuttle_launch = FALSE

	var/list/tracked_objectives = list()
	var/list/failed_objectives = list()

	var/objectives_spawned = FALSE
	var/next_objectives_update = -1
	var/completed_objectives = 0
	var/spawned_objectives = 0
	var/last_update = null
	var/round_end_time = -1

	var/next_threat_update = -1
	var/last_threat_level_warning = 0

	tick_usage_max = 50
	cpu_usage_max = 50

/subsystem/horde/proc/on_killed_syndicate(var/mob/living/L)

	if(!(L in tracked_enemies))
		return FALSE

	total_killed_syndicate++
	tracked_enemies -= L

	return TRUE

/subsystem/horde/proc/get_enemies_to_spawn()
	return clamp(10 + FLOOR(DECISECONDS_TO_SECONDS(world.time)/300,1),0,40) - length(tracked_enemies) //One additional enemy every 5 minutes.

/subsystem/horde/proc/check_hijack()

	if(!ENABLE_HIJACK)
		return FALSE

	/*
	var/area/exterior/grass/village/A = all_areas[/area/exterior/grass/village/]
	if(!A)
		log_error("HORDE MODE: Could not find the village area!")
		return FALSE

	var/desired_player_count = 1

	for(var/mob/living/advanced/player/P in A.contents)
		desired_player_count -= 1

	return desired_player_count > 0
	*/


/subsystem/horde/on_life()

	if(next_objectives_update > 0 && next_objectives_update <= world.time)
		next_objectives_update = -1
		update_objectives()

	if(next_threat_update > 0 && next_threat_update <= world.time)
		check_threat_level()
		next_threat_update = world.time + 600

	round_time++

	if(state == HORDE_STATE_WAITING)
		var/time_to_display = round_time_next - round_time
		set_status_display("mission","PREP\n[get_clock_time(time_to_display)]")
		if(time_to_display >= 0)
			set_message("Round starts in: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_GEARING
		round_time = 0
		round_time_next = HORDE_DELAY_GEARING
		announce("Central Command Update","Prepare for Landfall","All landfall are ordered to gear up for planetside combat. Estimated time until shuttle functionality: [CEILING(HORDE_DELAY_GEARING/60,1)] minutes.",ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')

	if(state == HORDE_STATE_GEARING)
		var/time_to_display = round_time_next - round_time
		set_status_display("mission","GEAR\n[get_clock_time(time_to_display)]")
		if(time_to_display >= 0)
			set_message("Loadout Period: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_BOARDING
		round_time = 0
		round_time_next = HORDE_DELAY_BOARDING
		announce("Central Command Update","Shuttle Boarding","All landfall crew are ordered to proceed to the hanger bay and prep for shuttle launch. Shuttles will be allowed to launch in [CEILING(HORDE_DELAY_BOARDING/60,1)] minutes. Objectives will be announced soon.",ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')
		next_objectives_update = world.time + 100


	if(state == HORDE_STATE_BOARDING)
		var/time_to_display = round_time_next - round_time
		set_status_display("mission","BRDN\n[get_clock_time(time_to_display)]")
		if(time_to_display >= 0)
			set_message("Boarding Period: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_LAUNCHING
		round_time = 0
		round_time_next = HORDE_DELAY_LAUNCHING
		announce("Central Command Update","Mission is a Go","Shuttles are prepped and ready to depart into Syndicate territory. Launch now.",ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')
		allow_shuttle_launch = TRUE

	if(state == HORDE_STATE_LAUNCHING)
		var/time_to_display = round_time_next - round_time
		set_status_display("mission","LNCH\n[get_clock_time(time_to_display)]")
		if(time_to_display >= 0)
			set_message("Launch Period: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_FIGHTING
		round_time = 0
		round_time_next = 0
		announce("Central Command Update","Incoming Syndicate Forces","Enemy forces spotted heading towards the Bravo landing zone. Prepare for enemy combatants.",ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')
		next_threat_update = world.time + 100

	return TRUE

/subsystem/horde/proc/find_viable_target()

	var/picks_remaining = 4

	while(picks_remaining > 0)
		CHECK_TICK(tick_usage_max,FPS_SERVER*10)
		picks_remaining--
		var/turf/chosen_target = get_turf(pick(possible_horde_targets))
		if(chosen_target.z != 3)
			continue
		var/obj/marker/map_node/N_end = find_closest_node(get_turf(chosen_target))
		if(!N_end)
			continue
		return N_end

	return null

/subsystem/horde/proc/find_viable_spawn()

	var/picks_remaining = 4

	while(picks_remaining > 0)
		CHECK_TICK(tick_usage_max,FPS_SERVER*10)
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

/subsystem/horde/Initialize()
	state = HORDE_STATE_WAITING
	round_time = 0
	round_time_next = HORDE_DELAY_WAIT
	return ..()

/subsystem/horde/proc/spawn_objectives(var/artifact_count = 1, var/kill_count = 3, var/rescue_count = 1)

	var/desired_spawn_objectives = min(artifact_count,length(possible_objective_spawns))
	var/desired_kill_objectives = min(kill_count,length(SSbosses.living_bosses))
	var/desired_rescue_objectives = min(rescue_count,length(possible_hostage_spawns),length(possible_hostage_types))

	LOG_DEBUG("Making [desired_spawn_objectives] spawn objectives.")
	LOG_DEBUG("Making [desired_kill_objectives] kill objectives.")
	LOG_DEBUG("Making [desired_rescue_objectives] rescue objectives.")

	for(var/i=1,i<=desired_spawn_objectives,i++)
		var/obj/marker/objective_spawn/S = pick(possible_objective_spawns)
		possible_objective_spawns -= S
		var/turf/T = get_turf(S)
		var/obj/structure/interactive/objective/O = new(T)
		INITIALIZE(O)
		GENERATE(O)
		tracked_objectives += O
		spawned_objectives++

	for(var/i=1,i<=desired_rescue_objectives, i++)
		var/obj/marker/hostage_spawn/S = pick(possible_hostage_spawns)
		possible_hostage_spawns -= S
		var/mob/living/advanced/npc/unique/hostage/L = pick(possible_hostage_types)
		possible_hostage_types -= L
		L = new L(get_turf(S))
		INITIALIZE(L)
		var/obj/item/handcuffs/H = new(get_turf(L))
		INITIALIZE(H)
		GENERATE(H)
		L.set_handcuffs(TRUE,H)
		tracked_objectives += L
		spawned_objectives++

	var/list/valid_boss_ids = list()

	for(var/mob/living/L in SSbosses.living_bosses)
		valid_boss_ids += L.id

	for(var/i=1, i<=desired_kill_objectives, i++)
		CHECK_TICK(tick_usage_max,0)
		var/chosen_id = pick(valid_boss_ids)
		valid_boss_ids -= chosen_id
		var/mob/living/L = SSbosses.tracked_bosses[chosen_id]
		HOOK_ADD("post_death","objective_death",L,src,.proc/queue_objectives_update)
		tracked_objectives += L
		spawned_objectives++

	objectives_spawned = TRUE

	return TRUE

/subsystem/horde/proc/queue_objectives_update()
	next_objectives_update = world.time + 30
	return TRUE

/subsystem/horde/proc/update_objectives()

	if(state == HORDE_STATE_BREAK)
		return FALSE

	if(!objectives_spawned)
		spawn_objectives()

	var/additional_text = ""

	var/objective_text = ""
	for(var/atom/A in tracked_objectives)
		if(isobj(A))
			var/obj/O = A
			if(istype(O,/obj/structure/interactive/objective))
				objective_text += "Secure \the [O.name]. \[<b>[O.qdeleting ? "COMPLETED" : "IN PROGRESS"]</b>\]<br>"
			else
				objective_text += "Destroy \the [O.name]. \[<b>[O.qdeleting ? "COMPLETED" : "IN PROGRESS"]</b>\]<br>"
			if(O.qdeleting)
				completed_objectives++
				tracked_objectives -= O
		else if(is_living(A))
			var/mob/living/L = A
			if(istype(L,/mob/living/advanced/npc/unique/hostage/))
				var/mob/living/advanced/npc/unique/hostage/H = L
				if(H.qdeleting)
					objective_text += "Rescue \the [H.name]. \[<b>FAILED</b>\]<br>"
					additional_text += "It appears that the crew fucked up so hard, [H.name]'s body cannot be recovered.<br>"
					completed_objectives++
					tracked_objectives -= L
				else
					objective_text += "Rescue \the [H.name]. \[<b>[!H.hostage ? "COMPLETED" : "IN PROGRESS"]</b>\]<br>"
					if(!H.hostage)
						if(H.dead)
							additional_text += "It appears that [H.name] was brought back dead. The crew will not be receiving a bonus for this tragedy.<br>"
						else
							additional_text += "As [H.name] was brought back in one piece, the crew will be receiving a bonus of 3000 credits.<br>"
							SSpayday.stored_payday += 3000
						completed_objectives++
						tracked_objectives -= L
			else
				objective_text += "Kill \the [L.name]. \[<b>[L.dead ? "COMPLETED" : "IN PROGRESS"]</b>\]<br>"
				if(L.dead)
					completed_objectives++
					tracked_objectives -= L

	last_update = objective_text

	for(var/obj/hud/button/objectives/B in all_objective_buttons)
		B.set_stored_text(last_update)
		if(B.owner)
			B.owner.to_chat(span("notice","Your objectives have been updated!"))

	if(additional_text)
		objective_text = "[objective_text]<br>[additional_text]"


	announce(
		"Central Command Update",
		"Objectives Update",
		"[objective_text]",
		ANNOUNCEMENT_STATION,
		'sound/voice/station/new_command_report.ogg'
	)

	if(completed_objectives >= spawned_objectives)
		var/possible_spawn_objectives = length(possible_objective_spawns)
		var/possible_kill_objectives = length(SSbosses.living_bosses)

		if(possible_spawn_objectives && possible_kill_objectives)
			state = HORDE_STATE_BREAK
			SSvote.create_vote(/vote/continue_round)
			return TRUE
		else
			broadcast_to_clients(span("vote","There was no vote for round end as there are no objectives to spawn!"))
			tick_rate = 0 //Stop horde processing.
			world.end(WORLD_END_NANOTRASEN_VICTORY)

	return FALSE


//100 equals failure.
//Warns at 75, 50, and 25.
//0 is neutral.
/subsystem/horde/proc/get_threat_level()

	. = 0

	for(var/mob/living/L in tracked_enemies) //Every syndicate in an area that you're supposed to defend increases the threat level by 2, except in cases where they've been dead for less than 60 seconds, which reduces it by 1.
		if(L.dead)
			if(L.time_of_death + 600 >= world.time)
				. -= 1
			continue
		var/area/A = get_area(L)
		if(A && !A.defend)
			continue
		. += 2

	for(var/mob/living/advanced/player/P in all_players) //Every living playing defending reduces the threat level by 1.
		if(P.dead || P.qdeleting)
			continue
		if(istype(P,/mob/living/advanced/player/antagonist/))
			. += 5
			continue
		var/area/A = get_area(P)
		if(!A.defend)
			continue
		. -= 1

	. -= completed_objectives*10 //Every objective completed reduces the threat level by 10.

	. += FLOOR(DECISECONDS_TO_SECONDS(world.time)/60,2) //Every 60 seconds is two points.

	return .

/subsystem/horde/proc/check_threat_level()

	var/threat_level = get_threat_level()

	var/reported_threat_level = clamp(round(threat_level,25),0,100)

	if(reported_threat_level != last_threat_level_warning && abs(reported_threat_level - last_threat_level_warning) >= 15)
		var/increase = reported_threat_level > last_threat_level_warning
		last_threat_level_warning = reported_threat_level
		switch(reported_threat_level)
			if(0)
				set_status_display("mission","CODE:\nGREEN.")
				announce("EMERGENCY ALERT SYSTEM.","THREAT LEVEL CLEARED.","ALERT: THREAT LEVEL SET TO: GREEN. EXCERSIZE TERM: FADE OUT.")
			if(25 to 50)
				set_status_display("mission","CODE:\nBLUE.")
				if(increase)
					announce("EMERGENCY ALERT SYSTEM.","THREAT LEVEL INCREASE.","ALERT: THREAT LEVEL RAISED TO: BLUE. EXCERSIZE TERM: SECOND GLANCE.")
				else
					announce("EMERGENCY ALERT SYSTEM.","THREAT LEVEL INCREASE.","ALERT: THREAT LEVEL LOWERED TO: BLUE. EXCERSIZE TERM: SECOND GLANCE.")
			if(50 to 75)
				set_status_display("mission","CODE:\nAMBER.")
				if(increase)
					announce("EMERGENCY ALERT SYSTEM.","THREAT LEVEL INCREASE.","ALERT: THREAT LEVEL RAISED TO: AMBER. EXCERSIZE TERM: ROAD HOUSE.\nALL GROUNDSIDE TEAMS ARE ORDERED TO FOCUS ON COMPLETION OF OBJECTIVES AND DEFENSE OF THE ALPHA-BRAVO LZ.")
				else
					announce("EMERGENCY ALERT SYSTEM.","THREAT LEVEL DECREASE.","ALERT: THREAT LEVEL LOWERED TO: AMBER. EXCERSIZE TERM: ROAD HOUSE.\nALL GROUNDSIDE TEAMS ARE ORDERED TO CONTINUE THEIR FOCUS ON OBJECTIVES AND THE DEFENSE OF THE ALPHA-BRAVO LZ.")
			if(75 to 99)
				set_status_display("mission","CODE:\nRED.")
				announce("EMERGENCY ALERT SYSTEM.","THREAT LEVEL INCREASE.","ALERT: THREAT LEVEL RAISED TO: RED. EXCERSIZE TERM: MARATHON SPRINT. MISSION FAILURE LIKELY.\n ALL GROUNDSIDE TEAMS ARE ORDERED TO FOCUS ON OBJECTIVE COMPLETION. IGNORING THIS ORDER MAY RESULT IN LOSS OF CREDITS AND/OR DEATH.")
			if(100)
				set_status_display("mission","CODE:\nBLACK.")
				announce("EMERGENCY ALERT SYSTEM.","THREAT LEVEL INCREASE.","ALERT: THREAT LEVEL RAISED TO: BLACK. EXCERSIZE TERM: LOADED PISTOL. MISSION FAILURE IMMINENT.\nSTARTING FIREMAN PROTOCOLS. EVACUATION ORDERS UNDERWAY. BLUESPACE CANONS ONLINE IN 5 MINUTES.")

	return threat_level