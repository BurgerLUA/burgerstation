//Here be shitcode.
//I need to improve this in the future.

#define HORDE_STATE_PRELOAD "preload" //We're preloading everything.
#define HORDE_STATE_WAITING "waiting" //Waiting for round to start.
#define HORDE_STATE_GEARING "gearing" //Everyone gears up.
#define HORDE_STATE_BOARDING "boarding" //Everyone boards the shuttles.
#define HORDE_STATE_LAUNCHING "launching" //Everyone is launching now.
#define HORDE_STATE_FIGHTING "fighting" //Fighting starts.
#define HORDE_STATE_HIJACK "hijack" //Station is under assault
#define HORDE_STATE_BREAK "break"

SUBSYSTEM_DEF(horde)
	name = "Horde Subsystem"
	desc = "Handles hordes and whatnot."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(1)
	var/round_time = 0 //In seconds.
	var/round_time_next = 0 //In seconds.
	var/state = HORDE_STATE_PRELOAD
	var/current_round = 1

	var/max_enemies = 10
	var/enemies_to_spawn = 0
	var/enemies_spawned = 0
	var/list/tracked_enemies = list()

	var/message_displayed = FALSE

	var/list/possible_horde_targets = list()

	var/killed_syndicate_total = 0
	var/killed_syndicate_round = 0
	var/spawned_enemies_round = 0

	var/next_hijack_check_time = 0

	var/allow_shuttle_launch = FALSE

	var/list/tracked_objectives = list()

	var/objectives_spawned = FALSE
	var/next_objectives_update = -1
	var/completed_objectives = 0
	var/last_update = null
	var/round_end_time = -1

/subsystem/horde/proc/on_killed_syndicate(var/mob/living/L)

	if(!(L in tracked_enemies))
		return FALSE

	killed_syndicate_total++
	killed_syndicate_round++

	if(killed_syndicate_round >= spawned_enemies_round)
		current_round++
		message_displayed = FALSE
		killed_syndicate_round = 0

	tracked_enemies -= L

	return TRUE


/subsystem/horde/proc/check_hijack()

	var/area/exterior/grass/village/A = all_areas[/area/exterior/grass/village/]
	if(!A)
		log_error("HORDE MODE: Could not find the village area!")
		return FALSE

	var/desired_player_count = CEILING(length(all_players) * 0.25,1)

	for(var/mob/living/advanced/player/P in A.contents)
		desired_player_count -= 1

	return desired_player_count > 0


/subsystem/horde/on_life()

	if(next_objectives_update > 0 && next_objectives_update <= world.time)
		update_objectives()
		next_objectives_update = -1

	round_time++

	if(state == HORDE_STATE_WAITING)
		var/time_to_display = round_time_next - round_time
		if(time_to_display >= 0)
			set_message("Round starts in: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_GEARING
		round_time = 0
		round_time_next = HORDE_DELAY_GEARING
		announce("Central Command Update","Prepare for Landfall","All landfall are ordered to gear up for planetside combat. Estimated time until shuttle functionality: 12 minutes.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')

	if(state == HORDE_STATE_GEARING)
		var/time_to_display = round_time_next - round_time
		if(time_to_display >= 0)
			set_message("Loadout Period: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_BOARDING
		round_time = 0
		round_time_next = HORDE_DELAY_BOARDING
		announce("Central Command Update","Shuttle Boarding","All landfall crew are ordered to proceed to the hanger bay and prep for shuttle launch. Shuttles will be allowed to launch in 2 minutes. Objectives will be announced soon.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')
		next_objectives_update = world.time + 100


	if(state == HORDE_STATE_BOARDING)
		var/time_to_display = round_time_next - round_time
		if(time_to_display >= 0)
			set_message("Boarding Period: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_LAUNCHING
		round_time = 0
		round_time_next = HORDE_DELAY_LAUNCHING
		announce("Central Command Update","Mission is a Go","Shuttles are prepped and ready to depart into Syndicate territory. Launch now.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')
		allow_shuttle_launch = TRUE

	if(state == HORDE_STATE_LAUNCHING)
		var/time_to_display = round_time_next - round_time
		if(time_to_display >= 0)
			set_message("Launch Period: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_FIGHTING
		round_time = 0
		round_time_next = 0
		announce("Central Command Update","Incoming Syndicate Forces","Enemy forces spotted heading towards the Alpha/Bravo landing zone. Prepare for enemy combatants.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')

	if(state == HORDE_STATE_FIGHTING)

		if(!message_displayed)
			LOG_DEBUG("Moving to round [current_round].")
			set_message("Round [current_round]")
			message_displayed = TRUE
			enemies_to_spawn = clamp(15 + (current_round * 5),15,min(50,max(15,length(all_players)*3))) - length(tracked_enemies)
			var/obj/marker/landmark/B = locate(pick("Bravo","Village"))
			var/obj/marker/map_node/N_end = find_closest_node(B)
			for(var/mob/living/advanced/npc/syndicate/S in world)
				if(S.map_spawn)
					continue
				if(!S.ai)
					continue
				var/obj/marker/map_node/N_start = find_closest_node(S)
				if(N_start)
					var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)
					if(found_path)
						S.ai.set_path(found_path)
						continue
				var/mob/living/advanced/player/P = locate() in view(VIEW_RANGE + ZOOM_RANGE,S)
				if(!P)
					qdel(S)

		if(ENABLE_HIJACK && next_hijack_check_time <= round_time)
			if(check_hijack())
				announce("Central Command Update","Incoming Syndicate Forces","Syndicate forces preparing to board the station. Predicted boarding location: Hanger Bay.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')
				state = HORDE_STATE_HIJACK
				round_time = 0
			else
				next_hijack_check_time = round_time + 60
			return TRUE

		var/wave_to_spawn = min(4,enemies_to_spawn)
		enemies_to_spawn -= wave_to_spawn
		var/list/possible_spawns = all_syndicate_spawns.Copy()
		spawn while(wave_to_spawn && length(possible_spawns))

			CHECK_TICK

			var/turf/chosen_spawn = pick(possible_spawns)
			possible_spawns -= chosen_spawn

			var/mob/living/advanced/player/P = locate() in range(VIEW_RANGE + ZOOM_RANGE,chosen_spawn)
			if(P)
				continue

			var/obj/marker/map_node/N_start = find_closest_node(get_turf(chosen_spawn))
			if(!N_start)
				continue

			var/list/possible_targets = possible_horde_targets.Copy()
			while(length(possible_targets))
				var/atom/chosen_target = pick(possible_targets)
				possible_targets -= chosen_target
				var/turf/target_turf = get_turf(chosen_target)

				if(target_turf.z != 3)
					continue

				var/obj/marker/map_node/N_end = find_closest_node(get_turf(chosen_target))
				if(!N_end)
					continue

				var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)
				if(!found_path)
					continue

				while(wave_to_spawn)
					var/turf/T = get_step(chosen_spawn,pick(DIRECTIONS_ALL))
					var/mob/living/advanced/npc/syndicate/S = new(T)
					INITIALIZE(S)
					S.ai.set_path(found_path)
					tracked_enemies += S
					wave_to_spawn--

	//if(state == HORDE_STATE_HIJACK)
		//Do stuff



	return TRUE

/subsystem/horde/Initialize()
	state = HORDE_STATE_WAITING
	round_time = 0
	round_time_next = HORDE_DELAY_WAIT
	return TRUE

/subsystem/horde/proc/spawn_objectives()

	var/desired_spawn_objectives = min(4,length(possible_objective_spawns))
	var/desired_kill_objectives = min(4,length(SSbosses.tracked_bosses))

	LOG_DEBUG("Making [desired_spawn_objectives] spawn objectives.")
	LOG_DEBUG("Making [desired_kill_objectives] kill objectives.")

	for(var/i=1,i<=desired_spawn_objectives,i++)
		var/obj/marker/objective_spawn/S = pick(possible_objective_spawns)
		possible_objective_spawns -= S
		var/turf/T = get_turf(S)
		var/obj/structure/interactive/objective/O = new(T)
		INITIALIZE(O)
		SPAWN(O)
		tracked_objectives += O

	var/list/valid_boss_ids = list()

	for(var/boss_id in SSbosses.tracked_bosses)
		valid_boss_ids += boss_id

	for(var/i=1, i<=desired_kill_objectives, i++)
		var/chosen_id = pick(valid_boss_ids)
		valid_boss_ids -= chosen_id
		var/mob/living/L = SSbosses.tracked_bosses[chosen_id]
		var/turf/T = get_turf(L)
		world.log << "Z of [L]: [T.z]."
		if(T.z != 2)
			continue
		HOOK_ADD("post_death","objective_death",L,src,.proc/queue_objectives_update)
		tracked_objectives += L

	objectives_spawned = TRUE

	return TRUE

/subsystem/horde/proc/queue_objectives_update()
	next_objectives_update = world.time + 30
	return TRUE

/subsystem/horde/proc/update_objectives()

	if(!objectives_spawned)
		spawn_objectives()

	var/objective_text = ""
	for(var/atom/A in tracked_objectives)
		var/turf/T = get_turf(A)
		if(isobj(A))
			var/obj/O = A
			objective_text += "Secure \the [O.name] at ([T.x],[T.y],[T.z]). \[<b>[O.qdeleting ? "COMPLETED" : "IN PROGRESS"]</b>\]<br>"
			if(O.qdeleting)
				completed_objectives++
				tracked_objectives -= O
		else if(is_living(A))
			var/mob/living/L = A
			objective_text += "Kill \the [L.name] at ([T.x],[T.y],[T.z]). \[<b>[L.dead ? "COMPLETED" : "IN PROGRESS"]</b>\]<br>"
			if(L.dead)
				completed_objectives++
				tracked_objectives -= L

	last_update = objective_text

	for(var/obj/hud/button/objectives/B in all_objective_buttons)
		B.set_stored_text(last_update)
		if(B.owner)
			B.owner.to_chat(span("notice","Your objectives have been updated!"))

	announce(
		"Central Command Update",
		"Objectives Update",
		"[objective_text]",
		ANNOUNCEMENT_STATION,
		'sounds/effects/station/new_command_report.ogg'
	)
