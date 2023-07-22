/gamemode/liberation
	name = "Liberation"
	desc = "Team deathmatch: UNSC vs URF!"
	team_points = list(
		TEAM_UNSC = 50,
		TEAM_URF = 50,
	)
	var/beacon_point_loss_time = 30
	var/beacon_point_loss = 2

/gamemode/liberation/New()
	. = ..()
	state = GAMEMODE_WAITING
	round_time = 0
	round_time_next = LIBERATION_DELAY_WAIT //Skip to gearing. Nothing to wait for.
	announce(name, "Starting new round...", desc)

/gamemode/liberation/on_life()
	. = ..()
	switch(state)
		if(GAMEMODE_WAITING)
			on_waiting()
		if(GAMEMODE_GEARING)
			on_gearing()
		if(GAMEMODE_LAUNCHING)
			on_launching()
		if(GAMEMODE_FIGHTING)
			on_fighting()

/gamemode/liberation/update_points()
	for(var/team in team_points)
		var/points = team_points[team]
		if(points > 0)
			continue
		switch(team)
			if(TEAM_UNSC)
				world.end(WORLD_END_SYNDICATE_VICTORY)
			if(TEAM_URF)
				world.end(WORLD_END_NANOTRASEN_VICTORY)
			if(TEAM_COVENANT)
				world.end(WORLD_END_NANOTRASEN_VICTORY)

/gamemode/liberation/proc/on_waiting()
	var/time_to_display = round_time_next - round_time
	set_status_display("mission", "PREP\n[get_clock_time(time_to_display)]")
	if(time_to_display >= 0)
		set_message("Round starts in: [get_clock_time(time_to_display)]",TRUE)
		return TRUE
	state = GAMEMODE_GEARING
	round_time = 0
	round_time_next = LIBERATION_DELAY_BOARDING
	SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(30*10 + 10)
	announce(
		"Central Command Update",
		"Prepare for Landfall",
		"All landfall crew are ordered to gear up for planetside combat. Estimated time until shuttle and drop pod functionality: 8 minutes.",
		ANNOUNCEMENT_STATION,
		'sound/voice/announcement/landfall_crew_8_minutes.ogg'
	)
	return TRUE

/gamemode/liberation/proc/on_gearing()
	var/time_to_display = round_time_next - round_time
	set_status_display("mission","GEAR\n[get_clock_time(time_to_display)]")
	if(time_to_display >= 0)
		set_message("Loadout Period: [get_clock_time(time_to_display)]",TRUE)
		return TRUE
	state = GAMEMODE_LAUNCHING
	round_time = 0
	round_time_next = LIBERATION_DELAY_LAUNCHING
	announce(
		"Central Command Update",
		"Shuttle Boarding",
		"All landfall crew are ordered to proceed to the hanger bay and prepare for battle. Shuttles will be allowed to launch in 2 minutes.",
		ANNOUNCEMENT_STATION,
		'sound/voice/announcement/landfall_crew_2_minutes.ogg'
	)
	return TRUE

/gamemode/liberation/proc/on_launching()
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
	announce("Central Command Mission Update","Mission is a Go","Shuttles are prepped and ready to depart into the Area of Operations. All crew are cleared to launch.",ANNOUNCEMENT_STATION,'sound/voice/announcement/landfall_crew_0_minutes.ogg')
	allow_launch = TRUE
	SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(5)
	return TRUE

/gamemode/liberation/proc/on_fighting()
	. = TRUE
	if(!length(capture_beacons))
		return
	for(var/obj/structure/capture_beacon/beacon as anything in capture_beacons)
		if(!beacon.controlled_by_team)
			continue
		if(beacon.being_captured_by)
			continue
		beacon.controlled_by_time++
		if(beacon.controlled_by_time >= beacon_point_loss_time)
			beacon.controlled_by_time = 0
			switch(beacon.controlled_by_team)
				if(TEAM_UNSC)
					if(team_points[TEAM_COVENANT])
						team_points[TEAM_COVENANT] = max(0, team_points[TEAM_COVENANT] - beacon_point_loss)
					if(team_points[TEAM_URF])
						team_points[TEAM_URF] = max(0, team_points[TEAM_URF] - beacon_point_loss)
				if(TEAM_URF)
					if(team_points[TEAM_COVENANT])
						team_points[TEAM_COVENANT] = max(0, team_points[TEAM_COVENANT] - beacon_point_loss)
					if(team_points[TEAM_UNSC])
						team_points[TEAM_UNSC] = max(0, team_points[TEAM_UNSC] - beacon_point_loss)
				if(TEAM_COVENANT)
					if(team_points[TEAM_URF])
						team_points[TEAM_URF] = max(0, team_points[TEAM_URF] - beacon_point_loss)
					if(team_points[TEAM_UNSC])
						team_points[TEAM_UNSC] = max(0, team_points[TEAM_UNSC] - beacon_point_loss)
			update_points()
			for(var/obj/hud/button/ticket_counter/ticket_counter as anything in hud_ticket_counters)
				ticket_counter.update_maptext()
