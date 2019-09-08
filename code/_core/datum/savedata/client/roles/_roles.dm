/savedata/client/roles
	name = "Role Data"
	desc = "The role that the user has."
	loaded_data = list("role" = 0)

/savedata/client/roles/get_file(var/file_id)
	return "roles.json"

/savedata/client/roles/New(var/client/new_owner)

	..()

	owner = new_owner

	var/full_path = "[get_folder(owner.ckey)][get_file()]"

	if(!fexists(full_path))
		text2file(json_encode(loaded_data),full_path)

	var/file_contents = file2text(full_path)
	loaded_data = json_decode(file_contents)

/savedata/client/roles/proc/add_role(var/role_to_add)
	loaded_data["role"] |= role_to_add
	save()
	return TRUE

/savedata/client/roles/proc/remove_role(var/role_to_add)
	loaded_data["role"] &= ~role_to_add
	save()
	return TRUE

/savedata/client/roles/proc/save()
	var/full_path = "[get_folder(owner.ckey)][get_file()]"
	fdel(full_path)
	text2file(json_encode(loaded_data),full_path)