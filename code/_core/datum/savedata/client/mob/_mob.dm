

/savedata/client/mob

/savedata/client/mob/get_folder(folder_id)
	. = replacetext(CHARACTER_PATH_FORMAT,"%CKEY",folder_id)
	return

/savedata/client/mob/reset_data()
	loaded_data = list(
		"name" = "Urist McRobust",
		"id" = "none",
		"last_saved_date" = 0,
		"last_saved_time" = 0,
		"species" = "human",
		"organs" = list(),
		"skills" = list(),
		"attributes" = list(),
		"currency" = 0,
		"known_topics" = list(),
		"nutrition" = 1000,
		"hydration" = 1000,
		"known_languages" = list(),
		"stored_mechs" = list()
	)

/savedata/client/mob/New(desired_ckey)
	..()
	reset_data()
	var/client/owner = CLIENT(ckey)
	if(owner)
		SSclient.ckey_to_mobdata[ckey] = src

/savedata/client/mob/PreDestroy()
	log_error("SERIOUS ERROR: Mobdata for [ckey] was destroyed!")
	return FALSE

/savedata/client/mob/get_file(file_id)
	var/returning = "[get_folder(ckey)][CHARACTER_FILE_FORMAT]"
	returning = replacetext(returning,"%CKEY",bot_controlled ? "BOT" : ckey)
	returning = replacetext(returning,"%CID",file_id)
	return returning

