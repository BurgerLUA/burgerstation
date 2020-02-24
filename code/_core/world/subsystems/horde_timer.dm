var/global/subsystem/horde/SShorde

#define HORDE_STATE_PRELOAD "preload"
#define HORDE_STATE_WAITING "waiting"
#define HORDE_STATE_GEARING "gearing"
#define HORDE_STATE_BRIEFING "briefing"
#define HORDE_STATE_BUILDING "building"
#define HORDE_STATE_FIGHTING "fighting"
#define HORDE_STATE_BREAK "break"

/subsystem/horde/
	name = "Horde Subsystem"
	desc = "Handles hordes and whatnot."
	priority = SS_ORDER_LAST
	tick_rate = 1 //SECONDS_TO_TICKS(1)
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

/subsystem/horde/proc/on_killed_syndicate()

	killed_syndicate_total++
	killed_syndicate_round++

	world.log << "Killed [killed_syndicate_round] enemies this round."
	world.log << "Killed [killed_syndicate_total] enemies this shift."

	if(killed_syndicate_round >= spawned_enemies_round)
		current_round++
		message_displayed = FALSE
		world.log << "NEW ROUND: [current_round]."

	killed_syndicate_round = 0

	return TRUE

/subsystem/horde/New()
	. = ..()
	SShorde = src
	return .

/subsystem/horde/on_life()

	round_time++

	if(state == HORDE_STATE_WAITING)
		var/time_to_display = round_time_next - round_time
		if(time_to_display >= 0)
			set_message("Round starts in: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_GEARING
		round_time = 0
		round_time_next = 600 //600 seconds.
		announce("Central Command Update","Prepare for Landfall","All crew are ordered to gear up for landfall. Estimated time until portal functionality: 11 minutes.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')
		spawn(600) //60 seconds
			announce("Station Announcement System","Captain's Console","Mission briefing starts in 10 minutes. Please head to the briefing area when you are geared up.",ANNOUNCEMENT_STATION,'sounds/effects/station/attention.ogg')

	if(state == HORDE_STATE_GEARING)
		var/time_to_display = round_time_next - round_time
		if(time_to_display >= 0)
			set_message("Loadout Period: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_BRIEFING
		round_time = 0
		round_time_next = 120
		announce("Station Announcement System","Captain's Console","Briefing is starting now.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')

	if(state == HORDE_STATE_BRIEFING)
		var/time_to_display = round_time_next - round_time
		if(time_to_display >= 0)
			set_message("Briefing Period: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_BUILDING
		round_time = 0
		round_time_next = 300
		announce("Station Announcement System","Captain's Console","The portal is now open. All landfall crew are ordered to enter the portal and establish a base of operations and prepare for enemy invasion.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')

	if(state == HORDE_STATE_BUILDING)
		var/time_to_display = round_time_next - round_time
		if(time_to_display >= 0)
			set_message("Build Period: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_FIGHTING
		round_time = 0
		round_time_next = 0
		announce("Central Command Update","Hostile Lifeforms","Hostile lifeforms detected. Prepare for combat. ETA until bluespace artillery functionality: Unknown.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')

	if(state == HORDE_STATE_FIGHTING)
		if(!message_displayed)
			set_message("Round [current_round]")
			message_displayed = TRUE
			enemies_to_spawn = 15 + (current_round * 5)
			spawned_enemies_round = enemies_to_spawn
			var/obj/marker/landmark/B = locate(pick("Bravo","Village"))
			var/obj/map_node/N_end = find_closest_node(B)
			for(var/mob/living/advanced/npc/syndicate/S in world)
				var/obj/map_node/N_start = find_closest_node(S)
				if(N_start)
					var/obj/map_node/list/found_path = N_start.find_path(N_end)
					if(found_path)
						S.ai.set_path(found_path)
						continue
				var/mob/living/advanced/player/P = locate() in view(VIEW_RANGE + ZOOM_RANGE,S)
				if(!P)
					qdel(S)

		var/wave_to_spawn = min(4,enemies_to_spawn)
		enemies_to_spawn -= wave_to_spawn
		var/list/possible_spawns = all_syndicate_spawns.Copy()
		spawn while(enemies_to_spawn && length(possible_spawns))
			var/turf/chosen_spawn = pick(possible_spawns)
			possible_spawns -= chosen_spawn

			var/mob/living/advanced/player/P = locate() in range(VIEW_RANGE + ZOOM_RANGE,chosen_spawn)
			if(P)
				sleep(-1)
				continue

			var/obj/map_node/N_start = find_closest_node(get_turf(chosen_spawn))
			if(!N_start)
				sleep(-1)
				continue

			var/list/possible_targets = possible_horde_targets.Copy()
			while(length(possible_targets))
				var/atom/chosen_target = pick(possible_targets)
				possible_targets -= chosen_target

				var/list/z_level = get_z_level(chosen_target)
				if(z_level[1] != 1 || z_level[2] != 2)
					sleep(-1)
					continue

				var/obj/map_node/N_end = find_closest_node(get_turf(chosen_target))
				if(!N_end)
					sleep(-1)
					continue

				var/obj/map_node/list/found_path = N_start.find_path(N_end)
				if(!found_path)
					sleep(-1)
					continue

				while(wave_to_spawn)
					var/turf/T = get_step(chosen_spawn,pick(DIRECTIONS_ALL))
					var/mob/living/advanced/npc/syndicate/S = new(T)
					S.Initialize()
					S.ai.set_path(found_path)
					world.log << "SPAWNING ENEMY!"
					for(var/mob/abstract/observer/O in world)
						O.force_move(T)
					wave_to_spawn--

	return TRUE

/subsystem/horde/Initialize()
	state = HORDE_STATE_WAITING
	round_time = 0
	round_time_next = 120
	return TRUE