/savedata/client/roles
	loaded_data = list("role" = FLAG_PERMISSION_NONE)

/savedata/client/roles/get_file(var/file_id)
	return "roles.json"

/savedata/client/roles/New(var/desired_ckey)

	..()

	//var/client/owner = CLIENT(ckey)

	var/full_path = "[get_folder(ckey)][get_file()]"

	if(!fexists(full_path))
		text2file(json_encode(loaded_data),full_path)

	var/file_contents = file2text(full_path)
	loaded_data = json_decode(file_contents)
	update()

/savedata/client/roles/proc/add_role(var/role_to_add)
	loaded_data["role"] |= role_to_add
	update()
	save()
	return TRUE

/savedata/client/roles/proc/remove_role(var/role_to_add)
	loaded_data["role"] &= ~role_to_add
	update()
	save()
	return TRUE

/savedata/client/roles/proc/save()
	var/full_path = "[get_folder(ckey)][get_file()]"
	fdel(full_path)
	text2file(json_encode(loaded_data),full_path)


/savedata/client/roles/proc/update()
	return TRUE