var/global/list/capture_beacons = list()

/obj/structure/capture_beacon
	name = "UNSC Navigational Beacon"
	desc = "A beacon used by the UNSC Navigational Beacon for navigational purposes."
	desc_extended = "Hacking it would really benefit your team."
	icon = 'icons/halo/structures/comm_tower.dmi'
	icon_state = "comm_tower_off"
	var/controlled_by_team
	var/controlled_by_time = 0
	var/being_captured_by
	var/immediate_point_loss_on_capture = 8

/obj/structure/capture_beacon/New()
	. = ..()
	capture_beacons += src

/obj/structure/capture_beacon/Destroy()
	. = ..()
	capture_beacons -= src

/obj/structure/capture_beacon/clicked_on_by_object(mob/caller, atom/object, location, control, params)
	if(!is_player(caller))
		return ..()

	var/faction
	if(istype(caller, /mob/living/advanced/player/covenant))
		faction = TEAM_COVENANT
	else if(istype(caller, /mob/living/advanced/player/nt))
		faction = TEAM_UNSC
	else if(istype(caller, /mob/living/advanced/player/antagonist))
		faction = TEAM_URF
	if(!faction)
		return
	var/gamemode/gamemode = SSgamemode.active_gamemode
	if(gamemode.state != GAMEMODE_FIGHTING)
		caller.to_chat(span("warning", "Not yet!"))
		return
	if(faction == controlled_by_team)
		caller.to_chat(span("warning", "[faction] is already controlling this, [pick("idiot", "moron", "headass", "imbecile")]."))
		return
	else if(faction == being_captured_by)
		caller.to_chat(span("warning", "[faction] is already capturing this, [pick("idiot", "moron", "headass", "imbecile")]."))
		return
	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(10)
	being_captured_by = faction
	PROGRESS_BAR(caller, src, 300, .proc/capture, caller)
	PROGRESS_BAR_CONDITIONS(caller, src, .proc/can_still_hack, caller)
	caller.visible_message(span("warning", "[caller] starts hacking [src]..."), \
						span("notice","You start to hack [src]..."))

/obj/structure/capture_beacon/get_examine_list(mob/examiner)
	. = ..()
	if(controlled_by_team)
		. += span("notice", "Currently being controlled by <b>[controlled_by_team]</b>.")
		var/gamemode/liberation/liberation = SSgamemode.active_gamemode
		if(istype(liberation))
			var/time_until_point_loss = round(liberation.beacon_point_loss_time - controlled_by_time)
			. += span("notice", "Next point loss in: <b>[time_until_point_loss]</b> seconds.")
	else
		. += span("warning", "Currently not being controlled by anyone.")

/obj/structure/capture_beacon/proc/capture(mob/living/advanced/player/caller)
	controlled_by_time = 0
	being_captured_by = null
	var/faction
	if(istype(caller, /mob/living/advanced/player/covenant))
		faction = TEAM_COVENANT
	else if(istype(caller, /mob/living/advanced/player/nt))
		faction = TEAM_UNSC
	else if(istype(caller, /mob/living/advanced/player/antagonist))
		faction = TEAM_URF
	controlled_by_team = faction
	var/gamemode/liberation/liberation = SSgamemode.active_gamemode
	if(faction && istype(liberation) && liberation.team_points[faction])
		liberation.team_points[faction] = min(100, liberation.team_points[faction] + 8)
		switch(faction)
			if(TEAM_UNSC)
				if(liberation.team_points[TEAM_COVENANT])
					liberation.team_points[TEAM_COVENANT] = max(0, liberation.team_points[TEAM_COVENANT] - immediate_point_loss_on_capture)
				if(liberation.team_points[TEAM_URF])
					liberation.team_points[TEAM_URF] = max(0, liberation.team_points[TEAM_URF] - immediate_point_loss_on_capture)
			if(TEAM_URF)
				if(liberation.team_points[TEAM_COVENANT])
					liberation.team_points[TEAM_COVENANT] = max(0, liberation.team_points[TEAM_COVENANT] - immediate_point_loss_on_capture)
				if(liberation.team_points[TEAM_UNSC])
					liberation.team_points[TEAM_UNSC] = max(0, liberation.team_points[TEAM_UNSC] - immediate_point_loss_on_capture)
			if(TEAM_COVENANT)
				if(liberation.team_points[TEAM_URF])
					liberation.team_points[TEAM_URF] = max(0, liberation.team_points[TEAM_URF] - immediate_point_loss_on_capture)
				if(liberation.team_points[TEAM_UNSC])
					liberation.team_points[TEAM_UNSC] = max(0, liberation.team_points[TEAM_UNSC] - immediate_point_loss_on_capture)
		liberation.update_points()
		for(var/obj/hud/button/ticket_counter/ticket_counter as anything in hud_ticket_counters)
			ticket_counter.update_maptext()
	visible_message(span("notice", "[src] gets captured by [caller]! Glory to [faction ? uppertext(faction) : "NO ONE"]!"))
	if(faction)
		icon_state = "comm_tower"
	else
		icon_state = "comm_tower_off"
	return TRUE

/obj/structure/capture_beacon/proc/can_still_hack(mob/living/advanced/player/caller)
	if(!caller || caller.dead || (get_dist(src, caller) >= 3))
		being_captured_by = null
		return FALSE
	return TRUE
