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

	var/message_displayed = FALSE

	var/list/possible_horde_targets = list()

	var/killed_syndicate_total = 0
	var/killed_syndicate_round = 0
	var/spawned_enemies_round = 0

	var/next_hijack_check_time = 0

	var/allow_shuttle_launch = FALSE

/subsystem/horde/proc/on_killed_syndicate()

	killed_syndicate_total++
	killed_syndicate_round++

	if(killed_syndicate_round >= spawned_enemies_round)
		current_round++
		message_displayed = FALSE

	killed_syndicate_round = 0

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
		announce("Central Command Update","Shuttle Boarding","All landfall crew are ordered to proceed to the hanger bay and prep for shuttle launch. Shuttles will be allowed to launch in 2 minutes.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')

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
			set_message("Round [current_round]")
			message_displayed = TRUE
			enemies_to_spawn = clamp(15 + (current_round * 5),15,min(50,max(15,length(all_players)*3)))
			spawned_enemies_round = enemies_to_spawn*0.75
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

		if(next_hijack_check_time <= round_time)
			if(check_hijack())
				world.log << "HIJACK!"
				state = HORDE_STATE_HIJACK
				round_time = 0
			else
				next_hijack_check_time = round_time + 60
			return TRUE

		var/wave_to_spawn = min(4,enemies_to_spawn)
		enemies_to_spawn -= wave_to_spawn
		var/list/possible_spawns = all_syndicate_spawns.Copy()
		spawn while(enemies_to_spawn && length(possible_spawns))

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

				if(chosen_target.z != 3)
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

					for(var/mob/abstract/observer/O in world)
						O.force_move(T)
					wave_to_spawn--

	//if(state == HORDE_STATE_HIJACK)
		//Do stuff


	return TRUE

/subsystem/horde/Initialize()
	state = HORDE_STATE_WAITING
	round_time = 0
	round_time_next = HORDE_DELAY_WAIT
	return TRUE