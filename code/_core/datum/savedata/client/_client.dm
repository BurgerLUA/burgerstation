/savedata/client/
	var/ckey
	var/cid
	var/bot_controlled = FALSE
	var/guest = FALSE

/savedata/client/proc/get_folder_id()

	if(bot_controlled)
		return "BOT"

	if(guest) //Only set if the config option is enabled (see below in New())
		return "~guests/[cid]"

	if(ckey)
		return ckey

	return "~ERROR"

/savedata/client/New(var/desired_ckey)

	var/client/owner = CLIENT(desired_ckey)

	if(!owner)
		CRASH("SAVE ERROR: savedata did not have a valid owner!")

	if(owner.guest && CONFIG("ENABLE_GUEST_CID_SAVING",FALSE))
		guest = TRUE
		cid = owner.computer_id

	ckey = desired_ckey

	return ..()

/savedata/client/get_folder()
	return replacetext(CKEY_PATH_FORMAT,"%CKEY",get_folder_id())

/savedata/client/get_files()
	return flist(get_folder())