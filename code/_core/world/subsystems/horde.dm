var/global/subsystem/horde/SShorde

#define HORDE_STATE_PRELOAD "preload"
#define HORDE_STATE_WAITING "waiting"
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
	var/enemies_spawned = 0

	var/message_displayed = FALSE

/subsystem/horde/New()
	. = ..()
	SShorde = src
	return .

/subsystem/horde/on_life()

	round_time++

	if(state == HORDE_STATE_WAITING)
		var/time_to_display = round_time_next - round_time
		if(time_to_display >= 0)
			set_message("Starting in: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_BUILDING
		round_time = 0
		round_time_next = 60

	if(state == HORDE_STATE_BUILDING)
		var/time_to_display = round_time_next - round_time
		if(time_to_display >= 0)
			set_message("Build Period: [get_clock_time(time_to_display)]",TRUE)
			return TRUE
		state = HORDE_STATE_FIGHTING
		round_time = 0
		round_time_next = 0

	if(state == HORDE_STATE_FIGHTING)
		if(!message_displayed)
			set_message("Round [current_round]")
			message_displayed = TRUE
		if(round_time > 10)
			var/penis = TRUE
			//Spawn enemies

	return TRUE

/subsystem/horde/Initialize()
	state = HORDE_STATE_WAITING
	round_time = 0
	round_time_next = 120
	return TRUE


/subsystem/horde/proc/start()
	set_message("Round 1")
