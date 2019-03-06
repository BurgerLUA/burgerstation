/savedata/client/
	var/client/owner

/savedata/client/get_folder()
	return replacetext(CKEY_PATH,"%CKEY",owner.ckey)