/savedata/client/
	var/ckey
	var/bot_controlled = FALSE

/savedata/client/New(var/desired_ckey)

	var/client/owner = CLIENT(desired_ckey)

	if(!owner)
		CRASH_SAFE("FATAL ERROR: Savedata did not have a valid owner!")
		return FALSE

	ckey = desired_ckey

	return ..()

/savedata/client/get_folder(var/folder_id)
	return replacetext(CKEY_PATH_FORMAT,"%CKEY",folder_id)

/savedata/client/get_files()
	return flist(get_folder(ckey))