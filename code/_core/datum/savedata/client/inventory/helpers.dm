/savedata/client/inventory/proc/load_json_data_from_id(var/character_id)

	var/filename = get_file(character_id)
	var/data = rustg_file_read(filename)

	if(!data)
		log_error("FATAL ERROR: NO INVENTORY DATA FOUND FOR [filename] for [ckey].")
		return FALSE

	return json_decode(data)

/savedata/client/inventory/proc/write_json_data_to_id(var/character_id,var/json_data)
	var/desired_file = get_file(character_id)
	var/data = json_encode(json_data)
	rustg_file_write(data,desired_file)
	return TRUE