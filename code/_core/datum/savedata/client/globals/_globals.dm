var/global/list/ckey_to_globaldata = list()

/savedata/client/globals
	loaded_data = list(
		"antag_tokens" = 0,
		"redeemed_rewards" = list(),
		"burgerbux" = 0,
		"stored_experience" = list(),
		"new_player" = TRUE
	)

/savedata/client/globals/get_file(var/file_id)
	return "global_stats.json"

/savedata/client/globals/New(var/desired_ckey)

	. = ..()

	load()

	var/client/owner = CLIENT(ckey)
	if(owner)
		ckey_to_globaldata[ckey] = src

	return .

/savedata/client/globals/proc/save()
	var/client/owner = CLIENT(ckey)
	var/full_path = "[get_folder(ckey)][get_file()]"
	loaded_data["new_player"] = FALSE
	rustg_file_write(json_encode(loaded_data),full_path)
	owner.to_chat(span("notice","Your global stats and settings have been saved."))
	return TRUE

/savedata/client/globals/proc/load()
	var/full_path = "[get_folder(ckey)][get_file()]"
	if(!fexists(full_path))
		rustg_file_write(json_encode(loaded_data),full_path)
	else
		loaded_data = json_decode(rustg_file_read(full_path))
	return TRUE