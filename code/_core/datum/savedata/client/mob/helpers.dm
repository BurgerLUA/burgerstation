/savedata/client/mob/proc/get_proper_id_from_filepath(var/file_string)
	var/file_name = get_filename(file_string)
	return replacetext(replacetext(file_name,"character_",""),".json","")

/savedata/client/mob/proc/get_proper_id_from_filename(var/file_string)
	return replacetext(replacetext(file_string,"character_",""),".json","")

/savedata/client/mob/proc/load_most_recent_character()
	var/list/file_paths = get_files()

	var/best_date = 0
	var/best_time = 0
	var/list/best_data

	for(var/v in file_paths)
		v = get_proper_id_from_filename(v)
		var/list/new_loaded_data = load_json_data_from_id(v)
		if(!best_time || time_x_newer_than_y(new_loaded_data["last_saved_date"],new_loaded_data["last_saved_time"],best_date,best_time))
			best_time = new_loaded_data["last_saved_time"]
			best_date = new_loaded_data["last_saved_date"]
			best_data = new_loaded_data

	return best_data

/savedata/client/mob/proc/get_next_character_id()

	var/list/file_numbers = list()

	for(var/v in get_files())
		file_numbers += text2num(get_proper_id_from_filename(v))

	var/best_number = 0
	for(var/i=1,i<=99,i++)
		if(!(i in file_numbers))
			best_number = i
			break

	if(best_number == 0)
		return FALSE
	else if(best_number < 10)
		return "0[best_number]"
	else
		return "[best_number]"

/savedata/client/mob/proc/load_json_data_from_id(var/character_id)

	var/filename = get_file(character_id)
	var/data = rustg_file_read(filename)

	if(!data)
		log_error("FATAL ERROR: NO DATA FOUND FOR [filename] for [ckey].")
		return FALSE

	return json_decode(data)

/savedata/client/mob/proc/write_json_data_to_id(var/character_id,var/json_data)
	json_data["id"] = character_id
	json_data["last_saved_date"] = get_date()
	json_data["last_saved_time"] = get_time()
	var/desired_file = get_file(character_id)
	var/data = json_encode(json_data)
	rustg_file_write(data,desired_file)
	return TRUE

/savedata/client/mob/proc/create_new_character(var/character_id)

	var/client/owner = CLIENT(ckey)

	if(world_state != STATE_RUNNING)
		owner?.mob?.to_chat(span("warning","The round is currently ending! Wait until next round!"))
		return FALSE

	if(text2num(character_id) > MAX_CHARACTERS)
		owner?.mob?.to_chat(span("warning","You exceed the maximum allocated characters! ([text2num(character_id)-1]/[MAX_CHARACTERS])"))
		return FALSE

	reset_data()
	loaded_data["id"] = character_id

	return TRUE

/savedata/client/mob/proc/save_character(var/mob/living/advanced/player/A,var/save_inventory = TRUE,var/force=FALSE,var/died=FALSE)

	if(!A)
		usr?.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 1000.</h2>"))
		CRASH_SAFE("FATAL ERROR: Tried to save a character without an actual character!")
		return FALSE

	if(!istype(A))
		usr?.to_chat(span("danger","<h2>Save failed. Tried to save [A.get_debug_name()]. Please contact the server owner with error code: 2000.</h2>"))
		CRASH_SAFE("FATAL ERROR: Tried to save [A.get_debug_name()], a non-player!")
		return FALSE

	if(!force && world_state != STATE_RUNNING)
		usr?.to_chat(span("danger","Your character was not saved as the round just ended!"))
		return FALSE

	if(!A.allow_save)
		usr?.to_chat(span("danger","You cannot save this character!"))
		return FALSE

	if(!A.finalized || !A.initialized)
		usr?.to_chat(span("warning","Your character was not saved as it is still initializing. This is to prevent save corruption. If you believe you received this message in error, contact Burger on discord."))
		return FALSE

	var/list/loaded_data = A.get_mob_data(save_inventory,force,died)
	if(write_json_data_to_id(loaded_data["id"],loaded_data))
		if(died)
			A.to_chat(span("notice","Your mind and body was backed up in the NanoTrasen cloning network..."))
		else
			A.to_chat(span("notice","Sucessfully saved character [A.name]."))
	else
		A.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 99.</h2>"))

	A.client?.globals?.save() //Save globals too. TODO: FIX THIS

	return TRUE