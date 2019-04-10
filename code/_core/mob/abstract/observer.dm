/mob/abstract/observer/
	name = "observer"
	desc = "Forever damned. Their spirit is powered by pure salt."
	desc_extended = "Those who perish in this world turn into these beings to then later be resurrected to die again and again."
	icon = 'icons/mob/abstract/ghosts.dmi'
	icon_state = "basic"
	ghost = TRUE
	layer = LAYER_GHOST

	movement_delay = 1

	var/list/spawning_buttons = list(
		/obj/button/load_character,
		/obj/button/new_character
	)

/mob/abstract/observer/no_move
	icon_state = ""

/mob/abstract/observer/no_move/Initialize()
	..()
	to_chat(span("Please load a character or create a new character to play using the buttons below."))

/mob/abstract/observer/auto_camera
	icon_state = ""

/mob/abstract/observer/Initialize()
	. = ..()
	name = "ghost of [ckey]"

	sight |= SEE_THRU

	for(var/v in spawning_buttons)
		var/obj/button/B = new v
		B.update_owner(src)

/mob/abstract/observer/Logout()
	..()
	qdel(src)

/mob/abstract/on_left_click(var/atom/object,location,control,params)
	if(is_wishgranter(object) || is_button(object))
		object.clicked_by_object(src,src,location,control,params)
		return TRUE

/mob/abstract/observer/verb/new_character()
	set name = "Create New Character"
	set category = "Data"

	var/client/C = src.client
	var/savedata/client/mob/U = C.savedata

	if(U.create_new_character(U.get_next_character_id()))
		var/mob/living/advanced/player/P = new(pick(spawnpoints_new_character),client)
		if(P.client)
			P.client.eye = P
			P.client.update_zoom(-1)
		P.chargen = TRUE
		open_menu(P,"appearance_editor")
		qdel(src)

/mob/abstract/observer/verb/load_character()
	set name = "Load Existing Character"
	set category = "Data"

	var/client/C = src.client
	var/savedata/client/mob/U = C.savedata

	if(!U.has_files())
		src << "You don't have a character to load! Please create a new character."
		return

	var/list/name_to_choice = list()

	for(var/file in U.get_files())
		var/filenum = U.get_proper_id_from_filename(file)
		var/list/local_loaded_data = U.load_json_data_from_id(filenum)
		var/name = "[filenum]: [local_loaded_data["name"]]"
		name_to_choice[name] = filenum

	var/choice = input("Choose a character to load.") in name_to_choice

	U.loaded_data = U.load_json_data_from_id(name_to_choice[choice])
	C.save_slot = name_to_choice[choice]
	src << "Successfully loaded character [U.loaded_data["name"]]."
	stop_sound('sounds/music/lobby.ogg',list(src))

	var/mob/living/advanced/player/P = new(src.loc,client)
	P.Initialize()
	qdel(src)

/mob/abstract/observer/verb/load_most_recent_character()
	set name = "Quickload"
	set category = "Data"

	var/client/C = src.client
	var/savedata/client/mob/U = C.savedata

	var/list/files = U.get_files()

	var/file_num = U.get_proper_id_from_filename(files[1])
	U.loaded_data = U.load_json_data_from_id(file_num)
	C.save_slot = file_num
	src << "Successfully loaded character [U.loaded_data["name"]]."
	stop_sound('sounds/music/lobby.ogg',list(src))

	var/mob/living/advanced/player/P = new(src.loc,client)
	P.Initialize()
	qdel(src)
