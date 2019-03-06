/savedata/client/connection_history
	name = "Connection History"

/savedata/client/connection_history/reset_data()
	loaded_data = list(
		"address" = owner.address,
		"byond_version" = owner.byond_version,
		"computer_id" = owner.computer_id,
		"connection_date" = get_date(),
		"connection_time" = get_time()
	)

/savedata/client/connection_history/New(var/client/new_owner)

	..()

	owner = new_owner

	reset_data()

	var/worst_date
	var/worst_time

	var/list/connection_files = get_files()

	if(length(connection_files) >= 5)
		for(var/file in connection_files)
			var/list/time_data = splittext(file,"_")
			var/local_date = time_data[1]
			var/local_time = time_data[2]
			if(!worst_date || !worst_time || !time_x_newer_than_y(local_date,local_time,worst_date,worst_time))
				worst_date = local_date
				worst_time = local_time

		if(worst_date && worst_time)
			var/file_to_delete = "[get_folder(owner.ckey)][worst_date]_[worst_time].json"
			fdel(file_to_delete)

	var/new_file_name = "[get_folder(owner.ckey)][loaded_data["connection_date"]]_[loaded_data["connection_time"]].json"
	var/new_file_data = json_encode(loaded_data)


	new_owner << new_file_name

	text2file(new_file_data,new_file_name)


/savedata/client/connection_history/get_folder(var/folder_id)
	return replacetext(CONNECTION_PATH_FORMAT,"%CKEY",folder_id)

/savedata/client/connection_history/get_files()
	return flist(get_folder(owner.ckey))