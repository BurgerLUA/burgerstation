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
		to_chat(span("warning","The round is currently ending! Wait until next round!"))
		return FALSE

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)

	if(!mobdata.has_files())
		to_chat(span("notice","You don't have a character to load! Please create a new character."))
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

	return .

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
			to_chat("You were unable to create a new character! Please inform BurgerBB of this issue with your ckey so they can investigate what happened with the following code: 01. Rejoining may fix this.")
			return FALSE

		var/character_id = mobdata.get_next_character_id()

		if(mobdata.create_new_character(character_id))
			var/turf/T = get_turf(pick(chargen_spawnpoints))
			var/mob/living/advanced/player/P = new(T,client)
			var/obj/marker/dev/D = locate() in world
			if(D && ENABLE_INSTALOAD) //Setup like this so the iff initializes properly.
				P.force_move(get_turf(D))
				P.start_chargen()
				P.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
				P.adjust_currency(10000)
			else
				P.force_move(T)
				P.start_chargen()
			P.save_id = character_id
			return TRUE
		else
			to_chat("You were unable to create a new character! Please inform BurgerBB of this issue with your ckey so they can investigate what happened with the following code: 02. Rejoining may fix this.")
			log_error("WARNING: [ckey] was unable to create a new character!")