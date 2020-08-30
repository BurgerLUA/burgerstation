/savedata/client/globals
	loaded_data = list(
		"antag_tokens" = 0,
		"redeemed_rewards" = list(),
		"burgerbux" = 0
	)

/savedata/client/globals/get_file(var/file_id)
	return "global_stats.json"

/savedata/client/globals/New(var/desired_ckey)

	. = ..()

	load()

	return .

/savedata/client/globals/proc/save()
	var/client/owner = CLIENT(ckey)
	var/full_path = "[get_folder(ckey)][get_file()]"
	rustg_file_write(json_encode(loaded_data),full_path)
	owner.to_chat(span("notice","Your global stats has been saved."))
	return TRUE

/savedata/client/globals/proc/load()
	var/full_path = "[get_folder(ckey)][get_file()]"
	if(!fexists(full_path))
		rustg_file_write(json_encode(loaded_data),full_path)
	else
		loaded_data = json_decode(rustg_file_read(full_path))
	return TRUE