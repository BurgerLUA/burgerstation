/gamemode/horde/defense
	name = "Horde Defense"
	var/current_wave = 1


/gamemode/horde/defense/add_objectives()
	add_objective(/objective/defense)
	next_objective_update = world.time + 100
	return TRUE


/gamemode/horde/defense/on_waiting()
	var/time_to_display = round_time_next - round_time
	set_status_display("mission","PREP\n[get_clock_time(time_to_display)]")
	if(time_to_display >= 0)
		set_message("Round starts in: [get_clock_time(time_to_display)]",TRUE)
		return TRUE
	state = GAMEMODE_GEARING
	round_time = 0
	round_time_next = HORDE_DELAY_GEARING
	SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(60*10 + 10)
	add_objectives()
	announce(
		"Central Command Update",
		"Prepare for Landfall",
		"All landfall crew are ordered to gear up for defense of high value object. Estimated time until portal functionality: 5 minutes.",
		ANNOUNCEMENT_STATION,
		//'sound/voice/announcement/landfall_crew_8_minutes.ogg'
	)
	return TRUE

/gamemode/horde/defense/on_gearing()
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
		"Portal Transit",
		"All landfall crew are ordered to proceed to the hanger bay and prep for portal transit. The gateway will be allowed to open in 2 minutes.",
		ANNOUNCEMENT_STATION,
		//'sound/voice/announcement/landfall_crew_2_minutes.ogg'
	)
	return TRUE

/gamemode/horde/defense/on_boarding()
	var/time_to_display = round_time_next - round_time
	set_status_display("mission","GATE\n[get_clock_time(time_to_display)]")
	if(time_to_display >= 0)
		set_message("Gating Period: [get_clock_time(time_to_display)]",TRUE)
		return TRUE
	state = GAMEMODE_LAUNCHING
	round_time = 0
	round_time_next = HORDE_DELAY_LAUNCHING
	announce(
		"Central Command Mission Update",
		"Mission is a Go",
		"The gateway is functional and ready to portal into the area of operations. All crew are cleared to enter. Hostile entities will appear in 5 minutes.",
		ANNOUNCEMENT_STATION,
		'sound/voice/announcement/landfall_crew_0_minutes.ogg'
	)
	allow_launch = TRUE
	SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(10)
	return TRUE

/gamemode/horde/defense/on_launching()
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
