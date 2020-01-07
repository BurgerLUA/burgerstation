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
	tick_rate = SECONDS_TO_TICKS(0.2)
	var/round_time = 0 //In seconds.
	var/round_time_next = 0 //In seconds.
	var/state = HORDE_STATE_PRELOAD
	var/current_round = 1

	var/max_enemies = 10
	var/enemies_to_spawn = 0
	var/enemies_spawned = 0

	var/message_displayed = FALSE


/subsystem/horde/proc/get_enemies_to_spawn()
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
		for(var/obj/structure/interactive/gateway/G in all_gateways)
			G.enable(TRUE)
		state = HORDE_STATE_FIGHTING
		round_time = 0
		round_time_next = 0
		announce("Central Command Update","Hostile Lifeforms","Hostile lifeforms detected. Prepare for combat. ETA until bluespace artillery functionality: Unknown.",ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')

	if(state == HORDE_STATE_FIGHTING)
		if(!message_displayed)
			set_message("Round [current_round]")
			message_displayed = TRUE
		if(round_time > 10)
			world.log << "Span enemies."

	return TRUE

/subsystem/horde/Initialize()
	state = HORDE_STATE_WAITING
	round_time = 0
	round_time_next = 120
	return TRUE