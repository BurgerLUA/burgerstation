/savedata/server/soapstone

/savedata/server/soapstone/get_file(var/z_level)
	return replacetext(SOAPSTONE_FILE_FORMAT,"%MAP",SSdmm_suite.z_level_to_file["[z_level]"])

/savedata/server/soapstone/proc/quick_write(var/list/data_to_write)

	if(!data_to_write || !length(data_to_write))
		return FALSE

	var/x = data_to_write["x"]
	var/y = data_to_write["y"]
	var/z = data_to_write["z"]
	var/unique_identifier = "[x]_[y]_[z]"

	var/file_name = get_file(z)

	if(!fexists(file_name))
		rustg_file_write("\"[unique_identifier]\":" + json_encode(data_to_write),file_name)
		log_debug("[file_name] not registered in soapstone data... creating...")
	else
		rustg_file_append(",\"[unique_identifier]\":" + json_encode(data_to_write),file_name)
		log_debug("[file_name] registered in soapstone data!")

	return TRUE

/savedata/server/soapstone/proc/quick_load()

	for(var/z_level in SSdmm_suite.z_level_to_file)

		var/file_name = get_file(z_level)

		log_debug("Loading file [file_name]...")

		var/json_data = rustg_file_read(file_name)

		if(!json_data)
			log_error("Warning: No soapstone data file found in [file_name].")
			continue

		var/list/formatted_data = json_decode("{" + json_data + "}")

		for(var/instance in formatted_data)

			var/x_cord = formatted_data[instance]["x"]
			var/y_cord = formatted_data[instance]["y"]
			var/z_cord = formatted_data[instance]["z"]

			var/turf/desired_loc = locate(x_cord,y_cord,z_cord)

			var/name = formatted_data[instance]["name"]
			var/ckey = formatted_data[instance]["ckey"]
			var/text = formatted_data[instance]["text"]

			var/dir = formatted_data[instance]["dir"]
			var/color = formatted_data[instance]["color"]

			var/date = formatted_data[instance]["date"]
			var/time = formatted_data[instance]["time"]

			var/obj/structure/interactive/soapstone_message/SM = new(desired_loc,dir)
			INITIALIZE(SM)
			SM.set_dir(dir)
			SM.owner = ckey
			SM.color = color
			SM.owner = name
			SM.ckey = ckey
			SM.soapstone_text = text
			SM.date = date
			SM.time = time
			if(color == "#000000")
				SM.invisibility = INVISIBLITY_GHOST
			FINALIZE(SM)