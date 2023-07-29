var/global/antag_count = 0
/*
/mob/abstract/observer/verb/load_most_recent_character()
	set name = "Quickload Character"
	set category = "Menu"

	if(world_state < STATE_RUNNING)
		to_chat(span("warning","The round is currently loading! Wait a bit!"))
		return FALSE

	if(world_state > STATE_RUNNING)
		to_chat(span("warning","The round is currently ending! Wait until next round!"))
		return FALSE

	if(!src.client)
		log_error("Attempted to quickload a character without a client!")
		return FALSE

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)

	var/list/files = mobdata.get_files()

	if(!files || !length(files))
		new_character()
		return FALSE

	var/file_num = mobdata.get_proper_id_from_filename(files[1])

	return src.client.load(mobdata,file_num)

/mob/abstract/observer/verb/load_character()
	set name = "Load Character"
	set category = "Menu"

	if(world_state < STATE_RUNNING)
		to_chat(span("warning","The round is currently loading! Wait a bit!"))
		return FALSE

	if(world_state > STATE_RUNNING)
		to_chat(span("warning","The round is currently ending! Wait until next round!"))
		return FALSE

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)

	if(!mobdata.has_files())
		to_chat(span("danger","You don't have a character to load! Please create a new character."))
		return

	var/list/name_to_choice = list()

	for(var/file in mobdata.get_files())
		var/filenum = mobdata.get_proper_id_from_filename(file)
		var/list/local_loaded_data = mobdata.load_json_data_from_id(filenum)
		if(!local_loaded_data || !local_loaded_data["name"])
			log_error("FATAL ERROR: Could not generate a valid name for a file! Something is broken! ([file],[filenum])")
			continue
		var/name = "[filenum]: [local_loaded_data["name"]]"
		name_to_choice[name] = filenum

	var/choice = input("Choose a character to load.") as null|anything in name_to_choice

	if(!choice || !is_valid(src))
		return FALSE

	var/file_num = name_to_choice[choice]
	. = client.load(mobdata,file_num)
*/

/mob/abstract/observer/proc/can_become_unsc()

	if(!is_observer(src))
		src.to_chat(span("warning","You cannot become an UNSC while your character is currently loaded!"))
		return FALSE

	var/gamemode_state = SSgamemode.active_gamemode.state

	if(gamemode_state <= GAMEMODE_WAITING)
		src.to_chat(span("warning","The game has not started yet! Wait until objectives are announced before becoming an UNSC!"))
		return FALSE

	if(length(all_unsc_markers) <= 0)
		src.to_chat(span("warning","There are no available roles!"))
		return FALSE

	return TRUE

/mob/abstract/observer/verb/become_unsc()
	set name = "Become UNSC"
	set category = "Menu"

	if(!can_become_unsc())
		return FALSE

	var/client/C = src.client

	var/choice = input("Are you sure you want to become an UNSC member? You will spawn in as a ODST trooper with predetermined gear.") as null|anything in list("Yes","No","Cancel")

	if(choice != "Yes")
		src.to_chat(span("notice","Good choice."))
		return FALSE

	var/list/valid_choices = list()

	for(var/k_id in all_unsc_markers)
		var/list/list_of_markers = list(all_unsc_markers[k_id])
		if(!length(list_of_markers))
			continue
		valid_choices += k_id

	var/unsc_choice = input("What role do you wish to be?","Role Selection.") as null|anything in valid_choices

	if(!unsc_choice)
		src.to_chat(span("notice","Good choice."))
		return FALSE

	if(!length(all_unsc_markers))
		src.to_chat(span("warning","Someone stole your slot! There are no UNSC slots left!"))
		return ..()

	if(!unsc_choice || !length(all_unsc_markers[unsc_choice]))
		src.to_chat(span("warning","Someone stole your slot! Pick another role!"))
		return ..()

	if(!can_become_unsc())
		return ..()

	var/obj/marker/unsc/chosen_marker = pick(all_unsc_markers[unsc_choice])
	all_unsc_markers[unsc_choice] -= chosen_marker
	if(!length(all_unsc_markers[unsc_choice]))
		all_unsc_markers -= unsc_choice

	var/savedata/client/mob/mobdata = MOBDATA(C.ckey)
	mobdata.reset_data()

	var/mob/living/advanced/player/unsc/P = new chosen_marker.spawn_type(get_turf(chosen_marker),C)
	INITIALIZE(P)
	FINALIZE(P)
	P.equip_loadout(P.loadout_to_use,TRUE)
	P.setup_iff()
	P.hook_faction()
	stop_music_track(P.client)

/mob/abstract/observer/proc/can_become_urf()

	if(!is_observer(src))
		src.to_chat(span("warning","You cannot become an Insurrection while your character is currently loaded!"))
		return FALSE

	var/gamemode_state = SSgamemode.active_gamemode.state

	if(gamemode_state <= GAMEMODE_WAITING)
		src.to_chat(span("warning","The game has not started yet! Wait until objectives are announced before becoming an Insurrectionist!"))
		return FALSE

	if(length(all_urf_markers) <= 0)
		src.to_chat(span("warning","There are no available roles!"))
		return FALSE

	return TRUE



/mob/abstract/observer/verb/become_urf()
	set name = "Become Insurrection"
	set category = "Menu"

	if(!can_become_urf())
		return FALSE

	var/client/C = src.client

	var/choice = input("Are you sure you want to become an Insurrection member? You will spawn in as a insurrectionist soldier with predetermined gear.") as null|anything in list("Yes","No","Cancel")

	if(choice != "Yes")
		src.to_chat(span("notice","Good choice."))
		return FALSE

	var/list/valid_choices = list()

	for(var/k_id in all_urf_markers)
		var/list/list_of_markers = list(all_urf_markers[k_id])
		if(!length(list_of_markers))
			continue
		valid_choices += k_id

	var/urf_choice = input("What role do you wish to be?","URF Selection.") as null|anything in valid_choices

	if(!urf_choice)
		src.to_chat(span("notice","Good choice."))
		return FALSE

	if(!length(all_urf_markers))
		src.to_chat(span("warning","Someone stole your slot! There are no Insurrection slots left!"))
		return ..()

	if(!urf_choice || !length(all_urf_markers[urf_choice]))
		src.to_chat(span("warning","Someone stole your slot! Pick another role!"))
		return ..()

	if(!can_become_urf())
		return ..()

	var/obj/marker/antag/chosen_marker = pick(all_urf_markers[urf_choice])
	all_urf_markers[urf_choice] -= chosen_marker
	if(!length(all_urf_markers[urf_choice]))
		all_urf_markers -= urf_choice

	var/savedata/client/mob/mobdata = MOBDATA(C.ckey)
	mobdata.reset_data()

	var/mob/living/advanced/player/urf/P = new chosen_marker.spawn_type(get_turf(chosen_marker),C)
	INITIALIZE(P)
	FINALIZE(P)
	P.equip_loadout(P.loadout_to_use,TRUE)
	P.setup_iff()
	P.hook_faction()
	stop_music_track(P.client)

/mob/abstract/observer/proc/can_become_covenant()

	if(!is_observer(src))
		src.to_chat(span("warning","You cannot become an Covenant while your character is currently loaded!"))
		return FALSE

	var/gamemode_state = SSgamemode.active_gamemode.state

	if(gamemode_state == GAMEMODE_WAITING)
		src.to_chat(span("warning","The game has not started yet! Wait until objectives are announced before becoming an Covenant!"))
		return FALSE

	if(length(all_covenant_markers) <= 0)
		src.to_chat(span("warning","There are no available roles!"))
		return FALSE

	return TRUE



/mob/abstract/observer/verb/become_covenant()
	set name = "Become Covenant"
	set category = "Menu"

	if(!can_become_covenant())
		return FALSE

	var/client/C = src.client

	var/choice = input("Are you sure you want to become a part of Covenant? You will spawn in as a one of the Covenant races soldier with predetermined gear.") as null|anything in list("Yes","No","Cancel")

	if(choice != "Yes")
		src.to_chat(span("notice","Good choice."))
		return FALSE

	var/list/valid_choices = list()

	for(var/k_id in all_covenant_markers)
		var/list/list_of_markers = list(all_covenant_markers[k_id])
		if(!length(list_of_markers))
			continue
		valid_choices += k_id

	var/covenant_choice = input("What role do you wish to be?","Species Selection.") as null|anything in valid_choices

	if(!covenant_choice)
		src.to_chat(span("notice","Good choice."))
		return FALSE

	if(!length(all_covenant_markers))
		src.to_chat(span("warning","Someone stole your slot! There are no Covenant slots left!"))
		return ..()

	if(!covenant_choice || !length(all_covenant_markers[covenant_choice]))
		src.to_chat(span("warning","Someone stole your slot! Pick another role!"))
		return ..()

	if(!can_become_covenant())
		return ..()

	var/obj/marker/covenant/chosen_marker = pick(all_covenant_markers[covenant_choice])
	all_covenant_markers[covenant_choice] -= chosen_marker
	if(!length(all_covenant_markers[covenant_choice]))
		all_covenant_markers -= covenant_choice

	var/savedata/client/mob/mobdata = MOBDATA(C.ckey)
	mobdata.reset_data()

	var/mob/living/advanced/player/covenant/P = new chosen_marker.spawn_type(get_turf(chosen_marker),C)
	INITIALIZE(P)
	FINALIZE(P)
	P.equip_loadout(P.loadout_to_use,TRUE)
	P.setup_iff()
	P.hook_faction()
	stop_music_track(P.client)
