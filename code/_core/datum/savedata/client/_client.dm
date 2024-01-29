/savedata/client/
	var/ckey
	var/bot_controlled = FALSE

/savedata/client/New(desired_ckey)

	var/client/owner = CLIENT(desired_ckey)

	if(!owner)
		CRASH("SAVE ERROR: savedata did not have a valid owner!")

	ckey = desired_ckey

	return ..()

/savedata/client/get_folder(folder_id)
	return replacetext(CKEY_PATH_FORMAT,"%CKEY",folder_id)

/savedata/client/get_files()
	return flist(get_folder(ckey))