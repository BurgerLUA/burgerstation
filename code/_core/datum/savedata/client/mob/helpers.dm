var/global/allow_loading = TRUE


/savedata/client/mob/proc/get_proper_id_from_filepath(file_string)
	var/file_name = get_filename(file_string)
	return replacetext(replacetext(file_name,"character_",""),".json","")


/savedata/client/mob/proc/get_proper_id_from_filename(file_string)
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


/savedata/client/mob/proc/load_json_data_from_id(character_id)

	var/filename = get_file(character_id)
	var/data = rustg_file_read(filename)

	if(!data)
		log_error("FATAL ERROR: NO DATA FOUND FOR [filename] for [ckey].")
		return FALSE

	return json_decode(data)


/savedata/client/mob/proc/write_json_data_to_id(character_id,json_data)
	json_data["id"] = character_id
	json_data["last_saved_date"] = get_date()
	json_data["last_saved_time"] = get_time()
	var/desired_file = get_file(character_id)
	var/data = json_encode(json_data)
	rustg_file_write(data,desired_file)
	return TRUE


/savedata/client/mob/proc/create_new_character(character_id)

	var/client/owner = CLIENT(ckey)

	if(!allow_loading)
		owner?.mob?.to_chat(span("danger","Loading is currently disabled due to cleaning feature. Please wait."))
		return FALSE

	if(world_state < STATE_RUNNING)
		owner?.mob?.to_chat(span("warning","The round is currently loading! Wait a bit!"))
		return FALSE

	if(world_state > STATE_RUNNING)
		owner?.mob?.to_chat(span("warning","The round is currently ending! Wait until next round!"))
		return FALSE

	var/max_characters = CONFIG("MAXIMUM_PLAYER_SAVES",10)
	if(text2num(character_id) > max_characters)
		owner?.mob?.to_chat(span("warning","You exceed the maximum allocated characters! ([text2num(character_id)-1]/[max_characters])"))
		return FALSE

	reset_data()
	loaded_data["id"] = character_id

	return TRUE


/savedata/client/mob/proc/save_character(mob/living/advanced/player/A,save_inventory = TRUE,died=FALSE)

	if(!A)
		usr?.to_chat(span("danger","<h2>Save failed. Tried to save NULL. Please contact the server owner with error code: 1000.</h2>"))
		CRASH("SAVE ERROR: Tried to save a character without an actual character!")

	if(A.qdeleting)
		usr?.to_chat(span("danger","<h2>Save failed. Tried to save [A.get_debug_name()]. Please contact the server owner with error code: 1001.</h2>"))
		CRASH("SAVE ERROR: Tried saving a character that was qdeleting!")

	if(A.loc == null)
		usr?.to_chat(span("danger","<h2>Save failed. Tried to save [A.get_debug_name()]. Please contact the server owner with error code: 1002.</h2>"))
		CRASH("SAVE ERROR: Tried saving a character that had a null loc!")

	if(!istype(A))
		usr?.to_chat(span("danger","<h2>Save failed. Tried to save [A.get_debug_name()]. Please contact the server owner with error code: 1003.</h2>"))
		CRASH("SAVE ERROR: Tried to save [A.get_debug_name()], a non-player!")

	if(!A.allow_save)
		usr?.to_chat(span("danger","You cannot save this character!"))
		return FALSE

	if(!A.finalized || !A.initialized)
		usr?.to_chat(span("warning","Your character was not saved as it is still initializing. This is to prevent save corruption. If you believe you received this message in error, contact Burger on discord."))
		return FALSE

	A.is_saving = TRUE
	var/list/loaded_data = A.get_mob_data(save_inventory,died)

	. = TRUE
	if(!length(loaded_data))
		A.to_chat(span("danger","FATAL ERROR: COULD NOT SAVE! Your character had no data! Contact burger on how this happened with error code: 2001."))
		log_error("Tried saving [A.get_debug_name()] with no loaded data!")
		. = FALSE
	else if(!length(loaded_data["organs"]))
		A.to_chat(span("danger","FATAL ERROR: COULD NOT SAVE! Your character had no organ data! Contact burger on how this happened with error code: 2002."))
		log_error("Tried saving [A.get_debug_name()] with no organ data!")
		. = FALSE
	else if(!length(loaded_data["skills"]))
		A.to_chat(span("danger","FATAL ERROR: COULD NOT SAVE! Your character had no skill data! Contact burger on how this happened with error code: 2003."))
		log_error("Tried saving [A.get_debug_name()] with no skill data!")
		. =  FALSE
	else if(!length(loaded_data["attributes"]))
		A.to_chat(span("danger","FATAL ERROR: COULD NOT SAVE! Your character had no attribute data! Contact burger on how this happened with error code: 2004."))
		log_error("Tried saving [A.get_debug_name()] with no attribute data!")
		. = FALSE
	else if(write_json_data_to_id(loaded_data["id"],loaded_data))
		if(died)
			A.to_chat(span("notice","Your mind and body was backed up in the NanoTrasen cloning network..."))
		else
			A.to_chat(span("notice","Sucessfully saved character [A.name]."))
	else
		A.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 2005.</h2>"))
		log_error("Failed to save [A.get_debug_name()] with write_json_data_to_id!")
		. = FALSE

	A.is_saving = FALSE


/savedata/client/mob/proc/delete_character(mob/living/advanced/player/A)

	if(!A || !A.ckey || !A.client)
		return

	if(A != usr)
		CRASH("[A.get_debug_name()] is not equal to [usr.get_debug_name()]!")
		return

	var/savedata/client/globals/GD = GLOBALDATA(A.ckey)

	if(!GD)
		CRASH("No globaldata found for [A.ckey]!")
		return

	if(A.save_id != loaded_data["id"])
		CRASH("Save id [A.save_id] is not equal to [src.loaded_data["id"]] for [A.ckey]!")
		return

	var/file_name = get_file(A.save_id)

	if(!fdel(file_name))
		CRASH("Could not delete file [file_name] for [A.ckey]!")
		return FALSE

	SStax.pay_taxes(A)

	var/total_value = A.get_value() + A.currency
	total_value = max(0,total_value)

	if(!GD.loaded_data["stored_experience"])
		GD.loaded_data["stored_experience"] = list()

	GD.loaded_data["stored_currency"] += total_value

	for(var/s_id in A.skills)
		var/experience/skill/S = A.skills[s_id]
		var/amount_to_add = max(0,S.get_xp() - S.level_to_xp(S.default_level))*0.5
		amount_to_add = FLOOR(amount_to_add,1)
		GD.loaded_data["stored_experience"][s_id] += amount_to_add

	for(var/s_id in A.attributes)
		var/experience/attribute/S = A.attributes[s_id]
		var/amount_to_add = max(0,S.get_xp() - S.level_to_xp(S.default_level))*0.5
		amount_to_add = FLOOR(amount_to_add,1)
		GD.loaded_data["stored_experience"][s_id] += amount_to_add

	A.client?.make_ghost(get_turf(A))

	qdel(A)

	return TRUE
