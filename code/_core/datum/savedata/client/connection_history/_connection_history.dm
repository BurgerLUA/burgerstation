#define CONNECTIONS_FILE_LIMIT 10


/savedata/client/connection_history

/savedata/client/connection_history/reset_data()

	var/client/owner = CLIENT(ckey)

	loaded_data = list(
		"address" = owner.address,
		"byond_version" = owner.byond_version,
		"computer_id" = owner.computer_id,
		"connection_date" = get_date(),
		"connection_time" = get_time()
	)

/savedata/client/connection_history/New(var/desired_ckey)

	. = ..()

	reset_data()

	var/list/connection_files = get_files()
	sortTim(connection_files, /proc/cmp_path_dsc)
	var/connections_length = length(connection_files)
	if(connections_length >= CONNECTIONS_FILE_LIMIT)
		for(var/i=CONNECTIONS_FILE_LIMIT,i<=connections_length,i++)
			var/file_name = "[get_folder(ckey)][connection_files[i]]"
			fdel(file_name)

	var/new_file_name = "[get_folder(ckey)][loaded_data["connection_date"]]_[loaded_data["connection_time"]].json"
	var/new_file_data = json_encode(loaded_data)

	rustg_file_write(new_file_data,new_file_name)

	return .


/savedata/client/connection_history/get_folder(var/folder_id)
	return replacetext(CONNECTION_PATH_FORMAT,"%CKEY",folder_id)

/savedata/client/connection_history/get_files()
	return flist(get_folder(ckey))