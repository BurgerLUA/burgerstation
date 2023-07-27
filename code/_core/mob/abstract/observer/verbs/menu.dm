/mob/abstract/observer/proc/can_become_urf()

	if(!is_observer(src))
		src.to_chat(span("warning","You cannot become an insurrectionist while your character is currently loaded!"))
		return FALSE

	var/client/C = src.client

	if(!C)
		return FALSE

	var/savedata/client/globals/GD = GLOBALDATA(C.ckey)

	if(!GD || !GD.loaded_data)
		src.to_chat(span("danger","Your globals data appears to be bugged. Message Burger with your ckey on discord so he can fix this."))
		return FALSE

	if(world_state < STATE_RUNNING)
		to_chat(span("warning","The round is currently loading! Wait a bit!"))
		return FALSE

	if(world_state > STATE_RUNNING)
		to_chat(span("warning","The round is currently ending! Wait until next round!"))
		return FALSE

	var/gamemode_state = SSgamemode.active_gamemode.state

	if(gamemode_state >= GAMEMODE_BREAK)
		src.to_chat(span("warning","The round is currently ending!"))
		return FALSE

	return TRUE

/mob/abstract/observer/verb/become_urf()
	set name = "Become Insurrectionist"
	set category = "Menu"

	if(!can_become_urf())
		return FALSE

	var/client/C = src.client

	var/choice = input("Are you sure you wish to become an insurrectionist?") as null|anything in list("Yes","No","Cancel")

	if(choice != "Yes")
		src.to_chat(span("notice","Good choice."))
		return FALSE

	var/list/valid_choices = list()

	for(var/k_id in all_urf_markers)
		var/list/list_of_markers = list(all_urf_markers[k_id])
		if(!length(list_of_markers))
			continue
		valid_choices += k_id

	var/urf_choice = input("What urf do you wish to be?","urf Selection.") as null|anything in valid_choices

	if(!urf_choice)
		src.to_chat(span("notice","Good choice."))
		return FALSE

	if(!length(all_urf_markers))
		src.to_chat(span("warning","Someone stole your slot! There are no insurrectionist slots left!"))
		return FALSE

	if(!urf_choice || !length(all_urf_markers[urf_choice]))
		src.to_chat(span("warning","Someone stole your slot! Pick another insurrectionist type!"))
		return FALSE

	if(!can_become_urf())
		return FALSE

	var/savedata/client/globals/GD = GLOBALDATA(C.ckey)
	if(!GD)
		src.to_chat(span("danger","Globaldata error detected. Report this to Burger on discord with error code: WEWLAD. Rejoining may fix this."))
		return FALSE

	var/obj/marker/urf/chosen_marker = pick(all_urf_markers[urf_choice])
	all_urf_markers[urf_choice] -= chosen_marker
	if(!length(all_urf_markers[urf_choice]))
		all_urf_markers -= urf_choice

	//GD.loaded_data["antag_tokens"] -= 1
//	src.to_chat(span("notice","You spend an urf token to become an urf. You now have <b>[GD.loaded_data["urf_tokens"]]</b> urf token(s)."))

//	var/savedata/client/mob/mobdata = MOBDATA(C.ckey)
//	mobdata.reset_data()

	var/mob/living/advanced/player/urf/P = new chosen_marker.spawn_type(get_turf(chosen_marker),C)
	INITIALIZE(P)
	FINALIZE(P)
	P.equip_loadout(P.loadout_to_use,TRUE)
	P.setup_iff()
	stop_music_track(P.client)

/mob/abstract/observer/proc/can_become_unsc()

	if(!is_observer(src))
		src.to_chat(span("warning","You cannot become a UNSC Soldier while your character is currently loaded!"))
		return FALSE

	var/client/C = src.client

	if(!C)
		return FALSE

	var/savedata/client/globals/GD = GLOBALDATA(C.ckey)

	if(!GD || !GD.loaded_data)
		src.to_chat(span("danger","Your globals data appears to be bugged. Message Burger with your ckey on discord so he can fix this."))
		return FALSE

	if(world_state < STATE_RUNNING)
		to_chat(span("warning","The round is currently loading! Wait a bit!"))
		return FALSE

	if(world_state > STATE_RUNNING)
		to_chat(span("warning","The round is currently ending! Wait until next round!"))
		return FALSE

	var/gamemode_state = SSgamemode.active_gamemode.state

	if(gamemode_state >= GAMEMODE_BREAK)
		src.to_chat(span("warning","The round is currently ending!"))
		return FALSE

	return TRUE

/mob/abstract/observer/verb/become_unsc()
	set name = "Become UNSC"
	set category = "Menu"

	if(!can_become_unsc())
		return FALSE

	var/client/C = src.client

	var/choice = input("Are you sure you wish to become a UNSC Soldier?") as null|anything in list("Yes","No","Cancel")

	if(choice != "Yes")
		src.to_chat(span("notice","Good choice."))
		return FALSE

	var/list/valid_choices = list()

	for(var/k_id in all_unsc_markers)
		var/list/list_of_markers = list(all_unsc_markers[k_id])
		if(!length(list_of_markers))
			continue
		valid_choices += k_id

	var/unsc_choice = input("What UNSC type do you wish to be?","UNSC Selection.") as null|anything in valid_choices

	if(!unsc_choice)
		src.to_chat(span("notice","Good choice."))
		return FALSE

	if(!length(all_unsc_markers))
		src.to_chat(span("warning","Someone stole your slot! There are no UNSC slots left!"))
		return FALSE

	if(!unsc_choice || !length(all_unsc_markers[unsc_choice]))
		src.to_chat(span("warning","Someone stole your slot! Pick another UNSC type!"))
		return FALSE

	if(!can_become_unsc())
		return FALSE

	var/savedata/client/globals/GD = GLOBALDATA(C.ckey)
	if(!GD)
		src.to_chat(span("danger","Globaldata error detected. Report this to Burger on discord with error code: WEWLAD. Rejoining may fix this."))
		return FALSE

	var/obj/marker/unsc/chosen_marker = pick(all_unsc_markers[unsc_choice])
	all_unsc_markers[unsc_choice] -= chosen_marker
	if(!length(all_unsc_markers[unsc_choice]))
		all_unsc_markers -= unsc_choice

	var/mob/living/advanced/player/unsc/P = new chosen_marker.spawn_type(get_turf(chosen_marker),C)
	INITIALIZE(P)
	FINALIZE(P)
	P.equip_loadout(P.loadout_to_use,TRUE)
	P.setup_iff()
	stop_music_track(P.client)

/mob/abstract/observer/proc/can_become_covenant()

	if(!is_observer(src))
		src.to_chat(span("warning","You cannot become a Covenant Soldier while your character is currently loaded!"))
		return FALSE

	var/client/C = src.client

	if(!C)
		return FALSE

	var/savedata/client/globals/GD = GLOBALDATA(C.ckey)

	if(!GD || !GD.loaded_data)
		src.to_chat(span("danger","Your globals data appears to be bugged. Message Burger with your ckey on discord so he can fix this."))
		return FALSE

	if(world_state < STATE_RUNNING)
		to_chat(span("warning","The round is currently loading! Wait a bit!"))
		return FALSE

	if(world_state > STATE_RUNNING)
		to_chat(span("warning","The round is currently ending! Wait until next round!"))
		return FALSE

	var/gamemode_state = SSgamemode.active_gamemode.state

	if(gamemode_state >= GAMEMODE_BREAK)
		src.to_chat(span("warning","The round is currently ending!"))
		return FALSE

	return TRUE

/mob/abstract/observer/verb/become_covenant()
	set name = "Become Covenant"
	set category = "Menu"

	if(!can_become_covenant())
		return FALSE

	var/client/C = src.client

	var/choice = input("Are you sure you wish to become a Covenant Soldier?") as null|anything in list("Yes","No","Cancel")

	if(choice != "Yes")
		src.to_chat(span("notice","Good choice."))
		return FALSE

	var/list/valid_choices = list()

	for(var/k_id in all_covenant_markers)
		var/list/list_of_markers = list(all_covenant_markers[k_id])
		if(!length(list_of_markers))
			continue
		valid_choices += k_id

	var/covenant_choice = input("What Covenant type do you wish to be?","Covenant Selection.") as null|anything in valid_choices

	if(!covenant_choice)
		src.to_chat(span("notice","Good choice."))
		return FALSE

	if(!length(all_covenant_markers))
		src.to_chat(span("warning","Someone stole your slot! There are no Covenant slots left!"))
		return FALSE

	if(!covenant_choice || !length(all_covenant_markers[covenant_choice]))
		src.to_chat(span("warning","Someone stole your slot! Pick another Covenant type!"))
		return FALSE

	if(!can_become_covenant())
		return FALSE

	var/savedata/client/globals/GD = GLOBALDATA(C.ckey)
	if(!GD)
		src.to_chat(span("danger","Globaldata error detected. Report this to Burger on discord with error code: WEWLAD. Rejoining may fix this."))
		return FALSE

	var/obj/marker/covenant/chosen_marker = pick(all_covenant_markers[covenant_choice])
	all_covenant_markers[covenant_choice] -= chosen_marker
	if(!length(all_covenant_markers[covenant_choice]))
		all_covenant_markers -= covenant_choice

	var/mob/living/advanced/player/covenant/P = new chosen_marker.spawn_type(get_turf(chosen_marker),C)
	INITIALIZE(P)
	FINALIZE(P)
	P.equip_loadout(P.loadout_to_use,TRUE)
	P.setup_iff()
	stop_music_track(P.client)