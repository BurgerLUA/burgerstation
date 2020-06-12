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
	var/data = file2text(filename)

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
	if(data)
		fdel(desired_file)
	return text2file(data,desired_file)

/savedata/client/mob/proc/create_new_character(var/character_id)

	if(!owner)
		CRASH_SAFE("Someone tried to create a character on a savedata that has no owner!")
		return FALSE

	if(world_state != STATE_RUNNING)
		owner.mob.to_chat(span("warning","The round is currently ending! Wait until next round!"))
		return FALSE

	if(text2num(character_id) > MAX_CHARACTERS)
		owner.mob.to_chat(span("warning","You exceed the maximum allocated characters! ([text2num(character_id)-1]/[MAX_CHARACTERS])"))
		return

	LOG_DEBUG("[owner] is creating a new character with the character id of [character_id].")

	reset_data()
	owner.save_slot = character_id

	return TRUE


/savedata/client/mob/proc/save_current_character(var/save_inventory = TRUE,var/force=FALSE)

	if(!owner)
		log_error("FATAL ERROR: Could not save a character because there was no owner attached! Usr: [usr].")
		return FALSE
	if(!owner.save_slot)
		owner.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 2.</h2>"))
		return FALSE
	if(!owner.mob)
		owner.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 3.</h2>"))
		return FALSE
	if(!is_advanced(owner.mob))
		owner.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 4.</h2>"))
		return FALSE
	if(!force && world_state != STATE_RUNNING)
		owner.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 5.</h2>"))
		return FALSE

	var/mob/living/advanced/player/A = owner.mob

	LOG_DEBUG("[owner] is saving their character [A.get_debug_name()]...")

	var/list/loaded_data = A.get_mob_data(save_inventory,force)

	if(write_json_data_to_id(owner.save_slot,loaded_data))
		owner.to_chat(span("notice","Sucessfully saved character [A.name]."))
	else
		owner.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 99.</h2>"))

	LOG_DEBUG("[owner] has finished saving their character [A.get_debug_name()].")