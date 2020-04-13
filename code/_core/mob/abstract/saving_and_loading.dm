/*
/mob/abstract/observer/verb/debug_next_character()
	set name = "Debug Next Character"
	set category = "Data"

	if(client)

		var/savedata/client/mob/U = mobdata

		if(!U)
			log_error("WARNING: [ckey] DOESN'T HAVE ANY CHARACTER DATA ATTACHED TO A GHOST.")
			return FALSE

		to_chat(U.get_next_character_id())
*/

/mob/abstract/observer/verb/new_character()
	set name = "Create New Character"
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
			P.to_chat(span("notice",
				"Welcome to Burgerstation! We are currently in Alpha Testing, which meansz that the came is largely incomplete and a \
				large majority of the game hasn't been coded yet. Please be patient with development, and have fun. If you wish to \
				experience the main game, please board the shuttle to the north.")
			)
			qdel(src)
			return TRUE
		else
			to_chat("You were unable to create a new character! Please inform BurgerBB of this issue with your ckey so they can investigate what happened. Rejoining may fix this.")

/mob/abstract/observer/verb/load_character()
	set name = "Load Existing Character"
	set category = "Data"

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

/mob/abstract/observer/verb/load_most_recent_character()
	set name = "Load Most Recent Character"
	set category = "Data"

	var/client/C = src.client
	var/savedata/client/mob/U = mobdata

	var/list/files = U.get_files()

	if(!files || !length(files))
		new_character()
		return FALSE

	var/file_num = U.get_proper_id_from_filename(files[1])

	. = C.load(U,file_num)
	qdel(src)
	return .

/client/proc/load(var/savedata/client/mob/U,var/file_num)

	U.loaded_data = U.load_json_data_from_id(file_num)
	src.save_slot = file_num
	to_chat(span("notice","Successfully loaded character [U.loaded_data["name"]]."))
	stop_music_track(src)

	var/mob/living/advanced/player/P = new(FALLBACK_TURF,src)
	P.mobdata = U
	INITIALIZE(P)

	return P
