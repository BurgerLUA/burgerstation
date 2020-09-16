var/global/list/ckey_to_mobdata = list()

/savedata/client/mob
	var/mob/living/advanced/player/attached_mob

/savedata/client/mob/Destroy()
	CRASH_SAFE("FATAL WARNING: SAVEDATA ATTEMPTED TO BE DESTROYED! SAVEDATA SHOULD NEVER BE DESTROYED!")
	return ..()

/savedata/client/mob/get_folder(var/folder_id)
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

/savedata/client/mob/New(var/desired_ckey)
	..()
	reset_data()
	var/client/owner = CLIENT(ckey)
	if(owner)
		ckey_to_mobdata[ckey] = src

/savedata/client/mob/Destroy()
	log_error("SERIOUS ERROR: Mobdata for [ckey] was destroyed!")
	return ..()

/savedata/client/mob/get_file(var/file_id)
	var/returning = "[get_folder(ckey)][CHARACTER_FILE_FORMAT]"
	returning = replacetext(returning,"%CKEY",bot_controlled ? "BOT" : ckey)
	returning = replacetext(returning,"%CID",file_id)
	return returning

