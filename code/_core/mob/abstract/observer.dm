/mob/abstract/observer/
	name = "observer"
	desc = "Forever damned. Their spirit is powered by pure salt."
	desc_extended = "Those who perish in this world turn into these beings to then later be resurrected to die again and again."
	icon = 'icons/mob/abstract/ghosts.dmi'
	icon_state = "basic"
	//ghost = TRUE
	layer = LAYER_GHOST

	movement_delay = 1

	var/list/spawning_buttons = list(
		/obj/hud/button/load_character,
		/obj/hud/button/new_character
	)

	collision_flags = FLAG_COLLISION_ETHEREAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/savedata/client/mob/mobdata

/mob/abstract/observer/on_left_click(var/atom/object,location,control,params)
	if(src.click_on_object(src,object,location,control,params))
		return TRUE
	return ..()

/mob/abstract/observer/on_right_click(var/atom/object,location,control,params)
	if(src.click_on_object(src,object,location,control,params))
		return TRUE
	return ..()

/mob/abstract/observer/Initialize()

	. = ..()

	if(!mobdata)
		mobdata = new(client)

	name = "ghost of [ckey]"

	sight |= SEE_THRU

	for(var/v in spawning_buttons)
		var/obj/hud/button/B = new v
		B.update_owner(src)

	to_chat(span("notice","Please load a character or create a new character to play using the buttons below."))

	return .

/mob/abstract/observer/Logout()
	. = ..()
	qdel(src)
	return .

/mob/abstract/observer/verb/new_character()
	set name = "Create New Character"
	set category = "Data"

	if(client)

		var/savedata/client/mob/U = mobdata

		if(!U)
			LOG_ERROR("WARNING: [ckey] DOESN'T HAVE ANY CHARACTER DATA ATTACHED TO A GHOST.")
			return FALSE

		if(U.create_new_character(U.get_next_character_id()))
			var/mob/living/advanced/player/P = new(pick(chargen_spawnpoints),client)
			P.start_chargen()
			return TRUE
		else
			LOG_ERROR("Something went wrong!")


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

	var/choice = input("Choose a character to load.") in name_to_choice

	if(!is_valid(src))
		return FALSE

	U.loaded_data = U.load_json_data_from_id(name_to_choice[choice])
	C.save_slot = name_to_choice[choice]
	to_chat(span("notice","Successfully loaded character [U.loaded_data["name"]]."))
	stop_sound('sounds/music/menu/lobby.ogg',list(src))

	var/mob/living/advanced/player/P = new(src.loc,client)
	P.mobdata = mobdata
	P.Initialize()
	qdel(src)

/mob/abstract/observer/verb/load_most_recent_character()
	set name = "Quickload"
	set category = "Data"

	var/client/C = src.client
	var/savedata/client/mob/U = mobdata

	var/list/files = U.get_files()

	if(!files || !length(files))
		new_character()
		return FALSE

	var/file_num = U.get_proper_id_from_filename(files[1])
	U.loaded_data = U.load_json_data_from_id(file_num)
	C.save_slot = file_num
	to_chat(span("notice","Successfully loaded character [U.loaded_data["name"]]."))
	stop_sound('sounds/music/menu/lobby.ogg',list(src))

	var/mob/living/advanced/player/P = new(src.loc,client)
	P.mobdata = mobdata
	P.Initialize()
	qdel(src)
