/obj/hud/button/new_character/
	name = "create a new character"
	desc = ""
	icon_state = "new_character"
	screen_loc = "CENTER-0.5,BOTTOM"

	flags = FLAGS_HUD_MOB

	has_quick_function = FALSE

/obj/hud/button/new_character/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(.)
		if(!is_observer(caller))
			caller.to_chat(span("notice","You cannot create a new character while your character is currently loaded!"))
			return TRUE

		if(world_state != STATE_RUNNING)
			caller.to_chat(span("notice","The game has not loaded yet!"))
			return TRUE

		var/mob/abstract/observer/O = caller
		O.new_character()


/obj/hud/button/load_character/
	name = "load an existing character"
	desc = ""
	icon_state = "load_character"
	screen_loc = "CENTER+0.5,BOTTOM"

	flags = FLAGS_HUD_MOB

	has_quick_function = FALSE

/obj/hud/button/load_character/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(.)
		if(!is_observer(caller))
			caller.to_chat(span("notice","You cannot load a new character while your character is currently loaded!"))
			return TRUE
		if(world_state != STATE_RUNNING)
			caller.to_chat(span("notice","The game has not loaded yet!"))
			return TRUE
		if(!allow_loading)
			caller.to_chat(span("danger","Cannot load your character currently as the server is undergoing a cleaning process."))
			return TRUE

		var/mob/abstract/observer/O = caller
		O.load_character()


/obj/hud/button/become_antag/
	name = "become antagonist"
	desc = ""
	icon_state = "become_antag"
	screen_loc = "CENTER+1.5,BOTTOM"

	flags = FLAGS_HUD_MOB

	has_quick_function = FALSE

/obj/hud/button/become_antag/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(is_observer(caller))
		var/mob/abstract/observer/O = caller
		O.become_antagonist()


/obj/hud/button/teleport_to_player/
	name = "spectate player"
	desc = ""
	icon_state = "square_round_small"
	screen_loc = "CENTER-1.5,BOTTOM"

	flags = FLAGS_HUD_MOB

	has_quick_function = FALSE

/obj/hud/button/teleport_to_player/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"ghost_overlay")
	add_overlay(I)

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


/obj/hud/button/dead_ghost/
	name = "ghost"
	desc = ""
	icon_state = "square_round_small"
	screen_loc = "CENTER,BOTTOM+2"

	flags = FLAGS_HUD_DEAD

	plane = PLANE_HUD_OBJ

	has_quick_function = FALSE

/obj/hud/button/dead_ghost/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(!. || !caller.client)
		return .


	if(istype(caller,/mob/living/advanced/player/virtual))
		if(!SSvirtual_reality || !SSvirtual_reality.current_virtual_reality)
			return .

		var/mob/living/L = caller

		var/virtual_reality/VR = SSvirtual_reality.current_virtual_reality

		var/list/team_list = VR.teams[L.loyalty_tag]
		if(!length(team_list))
			return FALSE
		team_list = team_list.Copy()
		team_list += "Cancel"

		var/mob/living/desired_spectate = input("Who do you wish to spectate?","Spectate","Cancel") as null|anything in team_list
		if(!desired_spectate || desired_spectate == "Cancel")
			return .

		if(!L.dead || desired_spectate.qdeleting)
			caller.to_chat(span("warning","Failed to spectate."))
			return .

		L.client.spectate(desired_spectate)
		return .

	caller.client.ghost()


/obj/hud/button/dead_ghost/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"ghost_overlay")
	I.appearance_flags = src.appearance_flags | RESET_COLOR
	add_overlay(I)
