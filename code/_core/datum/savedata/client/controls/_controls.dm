/savedata/client/controls
	loaded_data = list("null" = "null")
	//this is stored twice for a reason so players can confirm these are the settings they want with the new keys
	//prevents situations where people unbind escape or something and they can't quit out

/savedata/client/controls/get_file(var/file_id)
	return "controls.json"

/savedata/client/controls/New(var/desired_ckey)

	. = ..()

	var/client/owner = CLIENT(ckey)

	var/full_path = "[get_folder(ckey)][get_file()]"

	if(!fexists(full_path))
		rustg_file_append(json_encode(owner.macros.macros),full_path)
	else
		loaded_data = json_decode(rustg_file_read(full_path))
		owner.macros.macros = loaded_data

	return .

/savedata/client/controls/proc/save()
	var/client/owner = CLIENT(ckey)
	var/full_path = "[get_folder(ckey)][get_file()]"
	rustg_file_write(json_encode(owner.macros.macros),full_path)
	owner.to_chat(span("notice","Your control scheme has been saved."))