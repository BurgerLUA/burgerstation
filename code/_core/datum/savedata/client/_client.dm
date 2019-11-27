/savedata/client/
	var/client/owner
	var/bot_controlled = FALSE

/savedata/client/Destroy()
	owner = null
	return ..()

/savedata/client/New(var/client/new_owner)

	if(new_owner)
		owner = new_owner
	else
		bot_controlled = TRUE

	return ..()

/savedata/client/get_folder(var/folder_id)
	return replacetext(CKEY_PATH_FORMAT,"%CKEY",folder_id)

/savedata/client/get_files()
	return flist(get_folder(bot_controlled ? "BOT" : owner.ckey))