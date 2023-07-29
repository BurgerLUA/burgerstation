/obj/hud/button/teleport_to_player/
	name = "spectate player"
	desc = ""
	icon_state = "square_round_small"
	screen_loc = "CENTER-1.5,BOTTOM"

	flags_hud = FLAG_HUD_MOB

	has_quick_function = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/teleport_to_player/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"ghost_overlay")
	add_overlay(I)
	return .

/obj/hud/button/teleport_to_player/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(.)
		if(!is_observer(caller))
			caller.to_chat(span("notice","You cannot teleport as a non-observer!"))
			return TRUE
		if(world_state != STATE_RUNNING)
			caller.to_chat(span("notice","The game has not loaded yet!"))
			return TRUE

		var/list/valid_spectators = list()

		for(var/k in all_mobs_with_clients)
			var/mob/M = k
			valid_spectators[M.name] = M

		var/mob/selection = input("Who do you want to spectate?","Spectate Choice") as null|anything in valid_spectators

		if(selection)
			var/mob/M = valid_spectators[selection]
			caller.to_chat(span("notice","You are now spectating [M.name]."))
			caller.force_move(M.loc)

	return .


/obj/hud/button/dead_ghost/
	name = "ghost"
	desc = ""
	icon_state = "square_round_small"
	screen_loc = "CENTER,BOTTOM+2"

	flags_hud = FLAG_HUD_DEAD

	has_quick_function = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/dead_ghost/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && caller.client)
		caller.client.ghost()

	return .

/obj/hud/button/dead_ghost/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"ghost_overlay")
	add_overlay(I)
	return .


/obj/hud/button/become_urf/
	name = "become insurrectionist"
	desc = "United Rebel Front."
	desc_extended = "Become an insurrectionist, if possible."
	icon_state = "become_antag"
	screen_loc = "CENTER-0.5,BOTTOM"

	flags_hud = FLAG_HUD_MOB

	has_quick_function = FALSE

/obj/hud/button/become_urf/New(desired_loc)
	. = ..()
	var/gamemode/chungusmode = SSgamemode.active_gamemode
	if(chungusmode && isnull(chungusmode.team_points[TEAM_URF]))
		qdel(src)

/obj/hud/button/become_urf/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(is_observer(caller))
		var/mob/abstract/observer/O = caller
		O.become_urf()

/obj/hud/button/become_unsc/
	name = "become UNSC"
	desc = "United Nations Space Command."
	desc_extended = "Become a UNSC Soldier, if possible."
	icon_state = "become_nt"
	screen_loc = "CENTER+0.5,BOTTOM"

	flags_hud = FLAG_HUD_MOB

	has_quick_function = FALSE

/obj/hud/button/become_unsc/New(desired_loc)
	. = ..()
	var/gamemode/chungusmode = SSgamemode.active_gamemode
	if(chungusmode && isnull(chungusmode.team_points[TEAM_UNSC]))
		qdel(src)

/obj/hud/button/become_unsc/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(is_observer(caller))
		var/mob/abstract/observer/O = caller
		O.become_unsc()

/obj/hud/button/become_covenant/
	name = "become Covenant"
	desc = "The Covenant."
	desc_extended = "Become a Covenant Soldier, if possible."
	icon_state = "become_cov"
	screen_loc = "CENTER-0.5,BOTTOM+1"

	flags_hud = FLAG_HUD_MOB

	has_quick_function = FALSE

/obj/hud/button/become_covenant/New(desired_loc)
	. = ..()
	var/gamemode/chungusmode = SSgamemode.active_gamemode
	if(chungusmode && isnull(chungusmode.team_points[TEAM_COVENANT]))
		qdel(src)

/obj/hud/button/become_covenant/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(is_observer(caller))
		var/mob/abstract/observer/O = caller
		O.become_covenant()
