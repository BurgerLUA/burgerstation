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

/savedata/client/mob/proc/save_character(var/mob/living/advanced/player/A,var/save_inventory = TRUE,var/force=FALSE)

	if(!A)
		usr?.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 1000.</h2>"))
		CRASH_SAFE("FATAL ERROR: Tried to save a character without an actual character!")
		return FALSE

	if(!istype(A))
		usr?.to_chat(span("danger","<h2>Save failed. Tried to save [A.get_debug_name()]. Please contact the server owner with error code: 2000.</h2>"))
		return FALSE

	if(!force && world_state != STATE_RUNNING)
		usr?.to_chat(span("danger","Your character was not saved as the round just ended!"))
		return FALSE

	//LOG_DEBUG("[owner] is saving their character [A.get_debug_name()]...")

	var/list/loaded_data = A.get_mob_data(save_inventory,force)
	if(write_json_data_to_id(loaded_data["id"],loaded_data))
		A.to_chat(span("notice","Sucessfully saved character [A.name]."))
	else
		A.to_chat(span("danger","<h2>Save failed. Please contact the server owner with error code: 99.</h2>"))

	LOG_DEBUG("[A.client] has finished saving their character [A.get_debug_name()].")

	A.client?.globals?.save() //Save globals too. TODO: FIX THIS

	return TRUE

/*
/savedata/client/mob/proc/apply_data_to_mob(var/mob/living/advanced/player/A,var/do_teleport = TRUE,var/update_blends=TRUE)

	attached_mob = A

	//Name
	A.real_name = loaded_data["name"]
	A.sex = loaded_data["sex"]
	A.gender = loaded_data["gender"]
	A.currency = loaded_data["currency"]
	A.species = loaded_data["species"]
	A.nutrition = loaded_data["nutrition"] ? loaded_data["nutrition"] : 1000
	A.hydration = loaded_data["hydration"] ? loaded_data["hydration"] : 1000

	//LOG_DEBUG("[owner] is loading their character [A.real_name].")

	if(loaded_data["known_languages"])
		A.known_languages |= loaded_data["known_languages"]

	if(loaded_data["last_saved_date"] && loaded_data["last_saved_date"] != get_date())
		A.to_chat(span("notice","<h2>You are rewarded 2000 credits for logging in with this character today! Make sure to log in tomorrow to receive this reward again.</h2>"))
		A.adjust_currency(2000)

	//Organs
	for(var/id in loaded_data["organs"]) //This does not use load_and_create object as organs are special
		var/o_type = loaded_data["organs"][id]["type"]
		var/obj/item/organ/O = A.add_organ(o_type)
		if(loaded_data["organs"][id]["blend_data"])
			apply_blend_data(O, loaded_data["organs"][id]["blend_data"])
		if(loaded_data["organs"][id]["inventories"])
			for(var/i=1,i<=length(loaded_data["organs"][id]["inventories"]),i++)
				apply_inventory_data(O,loaded_data["organs"][id]["inventories"][i])
		O.update_sprite()

	//Skills
	for(var/id in loaded_data["skills"])
		var/experience/skill/S = A.get_skill(id)
		var/xp = ENABLE_XP_SAVING ? loaded_data["skills"][id] : S.level_to_xp(S.chargen_max_level)
		if(S)
			S.Initialize(xp)
		else
			log_error("Warning! Skill of ID \"[id]\" for [A] is invalid!")

	//Attributes
	for(var/id in loaded_data["attributes"])
		var/experience/attribute/S = A.get_attribute(id)
		var/xp = ENABLE_XP_SAVING ? loaded_data["attributes"][id] : S.level_to_xp(S.chargen_max_level)
		if(S)
			S.Initialize(xp)
		else
			log_error("Warning! Attribute of ID \"[id]\" for [A] is invalid!")

	if(do_teleport)
		var/obj/marker/dev/D = locate() in world
		if(D && ENABLE_INSTALOAD)
			A.force_move(get_turf(D))
			A.adjust_currency(10000)
		else
			var/obj/structure/interactive/bed/sleeper/C = length(cryo_spawnpoints) ? pick(cryo_spawnpoints) : pick(backup_spawnpoints)
			A.force_move(get_turf(C))
			C.buckle(A,silent=TRUE)

	if(update_blends)
		A.update_all_blends()
	else
		A.update_all_blends() //butts

	//LOG_DEBUG("[owner] is done loading their character [A.get_debug_name()].")

/savedata/client/mob/proc/apply_blend_data(var/obj/O, var/list/blend_data)
	for(var/id in blend_data)
		var/list/blend_list = blend_data[id]
		var/desired_id = value_or_null(blend_list,"id")
		var/desired_icon = value_or_null(blend_list,"icon")
		if(desired_icon)
			desired_icon = file(desired_icon)
		var/desired_icon_state = value_or_null(blend_list,"icon_state")
		var/desired_color = value_or_null(blend_list,"color")
		var/desired_blend = value_or_null(blend_list,"blend")
		var/desired_type = value_or_null(blend_list,"type")
		var/desired_layer = value_or_null(blend_list,"layer")
		O.add_blend(desired_id,desired_icon,desired_icon_state,desired_color,desired_blend,desired_type,TRUE,desired_layer)
*/