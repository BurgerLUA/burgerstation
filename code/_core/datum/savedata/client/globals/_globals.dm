/savedata/client/globals
	loaded_data = list(
		"antag_tokens" = 0
	)

/savedata/client/globals/get_file(var/file_id)
	return "global.json"

/savedata/client/globals/New(var/desired_ckey)

	. = ..()

	load()

	return .

/savedata/client/globals/proc/save()
	var/client/owner = CLIENT(ckey)
	var/full_path = "[get_folder(ckey)][get_file()]"
	fdel(full_path)
	text2file(json_encode(loaded_data),full_path)
	owner.to_chat(span("notice","Your global stats has been saved."))
	return TRUE

/savedata/client/globals/proc/load()
	var/full_path = "[get_folder(ckey)][get_file()]"
	if(!fexists(full_path))
		text2file(json_encode(loaded_data),full_path)
	else
		loaded_data = json_decode(file2text(full_path))
	return TRUE