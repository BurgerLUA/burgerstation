var/global/antag_count = 0

/mob/abstract/observer/verb/load_most_recent_character()
	set name = "Quickload Character"
	set category = "Menu"

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

	if(world_state != STATE_RUNNING)
		to_chat(span("danger","The round is currently ending! Wait until next round!"))
		return FALSE

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)

	if(!mobdata.has_files())
		to_chat(span("danger","You don't have a character to load! Please create a new character."))
		return

	var/list/name_to_choice = list()

	for(var/file in mobdata.get_files())
		var/filenum = mobdata.get_proper_id_from_filename(file)
		var/list/local_loaded_data = mobdata.load_json_data_from_id(filenum)
		var/name = "[filenum]: [local_loaded_data["name"]]"
		name_to_choice[name] = filenum

	var/choice = input("Choose a character to load.") as null|anything in name_to_choice

	if(!choice || !is_valid(src))
		return FALSE

	var/file_num = name_to_choice[choice]

	. = client.load(mobdata,file_num)

/mob/abstract/observer/verb/new_character()
	set name = "New Character"
	set category = "Menu"

	if(client)
		if(world_state != STATE_RUNNING)
			to_chat(span("warning","The round is currently ending! Wait until next round!"))
			return FALSE

		var/savedata/client/mob/mobdata = MOBDATA(ckey_last)

		if(!mobdata)
			log_error("WARNING: [ckey] doesn't have any mobdata!")
			to_chat(span("danger","You were unable to create a new character! Please inform BurgerBB of this issue with your ckey so they can investigate what happened with the following code: 01. Rejoining may fix this."))
			return FALSE

		var/character_id = mobdata.get_next_character_id()

		if(text2num(character_id) > MAX_CHARACTERS)
			src.to_chat(span("warning","You exceed the maximum allocated characters! ([text2num(character_id)-1]/[MAX_CHARACTERS])"))
			return FALSE

		if(mobdata.create_new_character(character_id))
			var/turf/T = get_turf(pick(chargen_spawnpoints))
			var/mob/living/advanced/player/P = new(T,client)
			var/obj/marker/dev/D = locate() in world
			if(D && ENABLE_INSTALOAD)
				P.force_move(get_turf(D))
				P.start_chargen()
				P.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
				P.adjust_currency(10000)
			else
				P.force_move(T)
				P.start_chargen()
			P.save_id = character_id
			P.tutorial = TRUE
			P.update_premiums()
			return TRUE
		else
			to_chat(span("danger","You were unable to create a new character! Please inform BurgerBB of this issue with your ckey so they can investigate what happened with the following code: 02. Rejoining may fix this."))
			log_error("WARNING: [ckey] was unable to create a new character!")
			return FALSE



/mob/abstract/observer/proc/can_become_antagonist()

	if(!is_observer(src))
		src.to_chat(span("warning","You cannot become an antag while your character is currently loaded!"))
		return FALSE

	var/client/C = src.client

	if(!C)
		return FALSE

	var/savedata/client/globals/GD = GLOBALDATA(C.ckey)

	if(!GD || !GD.loaded_data)
		src.to_chat(span("danger","Your globals data appears to be bugged. Message Burger with your ckey on discord so he can fix this."))
		return FALSE

	if(GD.loaded_data["antag_tokens"] <= 0)
		src.to_chat(span("danger","You don't have any antag tokens! To earn antag tokens, play the game normally and purchase them in a secret location in maintenance."))
		return FALSE

	if(world_state != STATE_RUNNING)
		src.to_chat(span("warning","The game has not loaded yet!"))
		return FALSE

	if(!SSgamemode || !SSgamemode.active_gamemode)
		src.to_chat(span("warning","The game has not started yet!"))
		return FALSE

	var/gamemode_state = SSgamemode.active_gamemode.state

	if(gamemode_state >= GAMEMODE_BREAK)
		src.to_chat(span("warning","The round is currently ending!"))
		return FALSE

	var/antag_limit = 2 + length(all_mobs_with_clients)*0.2

	if(antag_count > antag_limit)
		src.to_chat(span("warning","There are no available antag types!"))
		return FALSE

	if(length(all_antag_markers) <= 0)
		src.to_chat(span("warning","There are no available antag types!"))
		return FALSE

	return TRUE

/mob/abstract/observer/verb/become_antagonist()
	set name = "Become Antagonist"
	set category = "Menu"

	if(!can_become_antagonist())
		return FALSE

	var/client/C = src.client

	var/choice = input("Are you sure you wish to spend an antag token to become an antagonist?") as null|anything in list("Yes","No","Cancel")

	if(choice != "Yes")
		src.to_chat(span("notice","Good choice."))
		return FALSE

	var/list/valid_choices = list()

	for(var/k_id in all_antag_markers)
		var/list/list_of_markers = list(all_antag_markers[k_id])
		if(!length(list_of_markers))
			continue
		valid_choices += k_id

	var/antagonist_choice = input("What antagonist do you wish to be?","Antagonist Selection.") as null|anything in valid_choices

	if(!antagonist_choice)
		src.to_chat(span("notice","Good choice."))
		return FALSE

	if(!length(all_antag_markers))
		src.to_chat(span("warning","Someone stole your slot! There are no antagonist slots left!"))
		return FALSE

	if(!antagonist_choice || !length(all_antag_markers[antagonist_choice]))
		src.to_chat(span("warning","Someone stole your slot! Pick another antagonist type!"))
		return FALSE

	if(!can_become_antagonist())
		return FALSE

	var/savedata/client/globals/GD = GLOBALDATA(C.ckey)
	if(!GD)
		src.to_chat(span("danger","Globaldata error detected. Report this to Burger on discord with error code: WEWLAD. Rejoining may fix this."))
		return FALSE

	var/obj/marker/antag/chosen_marker = pick(all_antag_markers[antagonist_choice])
	all_antag_markers[antagonist_choice] -= chosen_marker
	if(!length(all_antag_markers[antagonist_choice]))
		all_antag_markers -= antagonist_choice

	GD.loaded_data["antag_tokens"] -= 1
	src.to_chat(span("notice","You spend an antag token to become an antagonist. You now have <b>[GD.loaded_data["antag_tokens"]]</b> antag token(s)."))

	var/savedata/client/mob/mobdata = MOBDATA(C.ckey)
	mobdata.reset_data()

	var/mob/living/advanced/player/antagonist/P = new chosen_marker.spawn_type(get_turf(chosen_marker),C)
	P.prepare()

	antag_count++