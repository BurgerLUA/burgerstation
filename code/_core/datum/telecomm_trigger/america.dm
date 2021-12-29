/telecomm_trigger/america
	name = "Space America Invasion"
	trigger_file = "data/server/telecomm_trigger/america.json"

/telecomm_trigger/america/New()
	. = ..()

	if(!trigger_file)
		log_error("Warning: Trigger file [src.type] didn't have a valid trigger_file!")
		return

	var/loaded_data = rustg_file_read(trigger_file)
	if(!loaded_data)
		log_error("Warning: Couldn't load [src.type] as file [trigger_file] was not found!")
		return

	var/list/loaded_list = json_decode(loaded_data)
	if(!length(loaded_list))
		log_error("Warning: Couldn't load [src.type] as file [trigger_file] was an invalid json file!")
		return

	selected_trigger_name = pick(loaded_list)

	if(!loaded_list[selected_trigger_name])
		log_error("Warning: Couldn't load [src.type] as file [trigger_file] had an incorrect json format!")
		return

	selected_trigger_regex = regex(loaded_list[selected_trigger_name])

/telecomm_trigger/america/trigger()
	. = ..()
	var/list/valid_turfs = list()

	for(var/k in all_invasion_markers)
		CHECK_TICK(25,FPS_SERVER*4)
		var/turf/T = get_turf(k)
		for(var/turf/simulated/floor/F in range(VIEW_RANGE*0.5,T))
			CHECK_TICK(25,FPS_SERVER*4)
			if(!F.is_safe_teleport())
				continue
			valid_turfs |= F

	if(!length(valid_turfs))
		return FALSE

	announce(
		"Incoming Message from the American Space Federation",
		"Declaration of Freedom",
		"Did someone say [selected_trigger_name]? We're coming to spread democracy in the area. Do not resist. God bless Space America.",
		sound_to_play = 'sound/voice/announcement/america_invade.ogg'
	)

	for(var/i=1,i<=30,i++)
		CHECK_TICK(25,FPS_SERVER*4)
		if(!length(valid_turfs))
			break
		var/turf/T = pick(valid_turfs)
		valid_turfs -= T
		for(var/d in DIRECTIONS_ALL)
			var/turf/T2 = get_step(T,d)
			valid_turfs -= T2
		CREATE(/obj/trigger/military_trap,T)
		sleep(10)


