/obj/hud/button/new_character/
	name = "create a new character"
	desc = ""
	icon_state = "new_character"
	screen_loc = "CENTER-0.5,BOTTOM"

	flags = FLAGS_HUD_MOB

	has_quick_function = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/new_character/clicked_on_by_object(var/mob/caller,object,location,control,params)

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

	return .

/obj/hud/button/load_character/
	name = "load an existing character"
	desc = ""
	icon_state = "load_character"
	screen_loc = "CENTER+0.5,BOTTOM"

	flags = FLAGS_HUD_MOB

	has_quick_function = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/load_character/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(.)
		if(!is_observer(caller))
			caller.to_chat(span("notice","You cannot load a new character while your character is currently loaded!"))
			return TRUE
		if(world_state != STATE_RUNNING)
			caller.to_chat(span("notice","The game has not loaded yet!"))
			return TRUE

		var/mob/abstract/observer/O = caller
		O.load_character()

	return .

/obj/hud/button/become_antag/
	name = "become antagonist"
	desc = ""
	icon_state = "become_antag"
	screen_loc = "CENTER+1.5,BOTTOM"

	flags = FLAGS_HUD_MOB

	has_quick_function = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/become_antag/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(.)
		if(!is_observer(caller))
			caller.to_chat(span("notice","You cannot become an antag while your character is currently loaded!"))
			return TRUE

		if(world_state != STATE_RUNNING)
			caller.to_chat(span("notice","The game has not loaded yet!"))
			return TRUE

		if(length(all_antag_markers) <= 0)
			caller.to_chat(span("notice","There are no available antag slots!"))
			return TRUE

		var/client/C = caller.client

		var/horde_state = SShorde.state

		if(horde_state == HORDE_STATE_PRELOAD)
			caller.to_chat(span("notice","The game has not loaded yet!"))
			return TRUE

		if(!C.globals.loaded_data)
			caller.to_chat(span("warning","Your globals data appears to be bugged. Message Burger with your ckey on discord so he can fix this."))
			return FALSE
		if(C.globals.loaded_data["antag_tokens"] <= 0)
			caller.to_chat(span("notice","You don't have any antag tokens! To earn antag tokens, play the game normally and purchase them in a secret location in maintenance."))
			return .

		if(horde_state == HORDE_STATE_WAITING)
			caller.to_chat(span("notice","The game hasn't started yet! Waiting until the first central command announcement to join!"))
			return TRUE

		if(horde_state != HORDE_STATE_GEARING)
			caller.to_chat(span("notice","It's too late to become an antag now!"))
			return TRUE

		var/choice = input("Are you sure you wish to spend an antag token to become an antagonist? You will spawn in as a Syndicate Assassin with predetermined gear.") as null|anything in list("Yes","No","Cancel")

		if(choice != "Yes")
			caller.to_chat(span("notice","Good choice."))
			return FALSE

		if(horde_state != HORDE_STATE_GEARING)
			caller.to_chat(span("notice","It's too late to become an antag now!"))
			return TRUE

		if(length(all_antag_markers) <= 0)
			caller.to_chat(span("notice","There aren't enough antag slots left! Better luck next time!"))
			return TRUE

		caller.client.globals.loaded_data["antag_tokens"] -= 1 //We don't save here because there might be an exploit where you don't save or something.
		caller.to_chat(span("notice","You spend an antag token to become an antagonist. You now have [caller.client.globals.loaded_data["antag_tokens"]] token(s)."))
		caller.client.globals.save()

		var/obj/marker/antag/M = pick(all_antag_markers)
		all_antag_markers -= M
		var/savedata/client/mob/mobdata = MOBDATA(C.ckey)
		mobdata.reset_data()
		var/mob/living/advanced/player/antagonist/syndicate/SP = new(get_turf(M),C)
		SP.prepare()

	return .


/obj/hud/button/teleport_to_player/
	name = "spectate player"
	desc = ""
	icon_state = "square_round_small"
	screen_loc = "CENTER-1.5,BOTTOM"

	flags = FLAGS_HUD_MOB

	has_quick_function = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/teleport_to_player/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"ghost_overlay")
	add_overlay(I)
	return .

/obj/hud/button/teleport_to_player/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(.)
		if(!is_observer(caller))
			caller.to_chat(span("notice","You cannot teleport as a non-observer!"))
			return TRUE
		if(world_state != STATE_RUNNING)
			caller.to_chat(span("notice","The game has not loaded yet!"))
			return TRUE

		var/list/valid_spectators = list()

		for(var/mob/M in all_mobs_with_clients)
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

	flags = FLAGS_HUD_DEAD

	has_quick_function = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/dead_ghost/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(. && caller.client)
		caller.client.ghost()

	return .

/obj/hud/button/dead_ghost/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"ghost_overlay")
	add_overlay(I)
	return .