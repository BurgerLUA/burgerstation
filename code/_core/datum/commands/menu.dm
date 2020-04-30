/mob/living/advanced/player/verb/logout()
	set name = "Save and Quit"
	set desc = "Saves and quits your character, returning you to the main menu."
	set category = "Menu"

	if(!loc)
		return FALSE

	var/area/A = get_area(src)

	if(mobdata && mobdata.loaded_data && mobdata.loaded_data["tutorial"] == 1)
		var/question = input("Are you sure you want to quit? All unsaved progress will be lost.") in list("Yes","No")
		if(question == "Yes")
			make_ghost()
			return TRUE
	if(mobdata && mobdata.loaded_data && mobdata.loaded_data["tutorial"] == 2)
		var/question = input("Are you sure you want to save and quit?") in list("Yes","No")
		if(question == "Yes")
			save(null)
			make_ghost()
			return TRUE
	else if(can_save(A))
		var/question = input("Are you sure you want to save and quit?") in list("Yes","No")
		if(question == "Yes" && can_save(A))
			save()
			make_ghost()
			qdel(src)
			return TRUE

	return FALSE

/mob/abstract/observer/verb/load_most_recent_character()
	set name = "Quickload Character"
	set category = "Menu"

	if(!src.client)
		log_error("Attempted to quickload a character without a client!")
		return FALSE

	var/savedata/client/mob/U = mobdata

	var/list/files = U.get_files()

	if(!files || !length(files))
		new_character()
		return FALSE

	var/file_num = U.get_proper_id_from_filename(files[1])

	. = src.client.load(U,file_num)
	qdel(src)
	return .


/mob/abstract/observer/verb/load_character()
	set name = "Load Character"
	set category = "Menu"

	var/client/C = src.client

	var/savedata/client/mob/U = mobdata

	if(!U.has_files())
		to_chat(span("notice","You don't have a character to load! Please create a new character."))
		return

	var/list/name_to_choice = list()

	for(var/file in U.get_files())
		var/filenum = U.get_proper_id_from_filename(file)
		var/list/local_loaded_data = U.load_json_data_from_id(filenum)
		var/name = "[filenum]: [local_loaded_data["name"]]"
		name_to_choice[name] = filenum

	var/choice = input("Choose a character to load.") as null|anything in name_to_choice

	if(!choice || !is_valid(src))
		return FALSE

	var/file_num = name_to_choice[choice]

	. = C.load(U,file_num)
	qdel(src)
	return .

/mob/abstract/observer/verb/new_character()
	set name = "New Character"
	set category = "Data"

	if(client)

		var/savedata/client/mob/U = mobdata

		if(!U)
			log_error("WARNING: [ckey] DOESN'T HAVE ANY CHARACTER DATA ATTACHED TO A GHOST.")
			return FALSE

		if(U.create_new_character(U.get_next_character_id()))
			var/turf/T = get_turf(pick(chargen_spawnpoints))
			var/mob/living/advanced/player/P = new(T,client)
			P.mobdata = U
			var/obj/marker/dev/D = locate() in world
			if(D && ENABLE_INSTALOAD)
				P.force_move(get_turf(D))
				P.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
			else
				P.force_move(T)
			P.start_chargen()
			qdel(src)
			return TRUE
		else
			to_chat("You were unable to create a new character! Please inform BurgerBB of this issue with your ckey so they can investigate what happened. Rejoining may fix this.")
