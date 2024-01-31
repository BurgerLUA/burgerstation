/savedata/
	var/list/loaded_data = list()

/savedata/proc/reset_data()
	loaded_data = list()

/savedata/proc/get_folder(folder_id)
	return ""

/savedata/proc/get_file(file_id)
	return ""

/savedata/proc/get_files()
	return flist(get_folder())

/savedata/proc/has_files()
	return length(get_files())