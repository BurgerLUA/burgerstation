/savedata/client/settings
	name = "Client Settings"
	desc = "The settings the client has"
	loaded_data = list(
		"volume_master" = 70,
		"volume_fx" = 70,
		"volume_ambient" = 50,
		"volume_music" = 70,
		"volume_footsteps" = 50,
		"fps_client" = FPS_CLIENT,
		"hud_colors" = list(
			"#3D5E80","#48728B","#5D96A0","#FFFFFF","#335871","#FE0000"
		)
	)

/savedata/client/settings/get_file(var/file_id)
	return "settings.json"

/savedata/client/settings/New(var/client/new_owner)

	..()

	owner = new_owner

	var/full_path = "[get_folder(owner.ckey)][get_file()]"

	if(!fexists(full_path))
		text2file(json_encode(loaded_data),full_path)

	var/file_contents = file2text(full_path)
	loaded_data |= json_decode(file_contents)
	if(loaded_data["fps_client"])
		new_owner.fps = loaded_data["fps_client"]

/savedata/client/settings/proc/change_setting(var/setting_id,var/setting_value)
	loaded_data[setting_id] = setting_value
	save()
	return TRUE

/savedata/client/settings/proc/save()
	var/full_path = "[get_folder(owner.ckey)][get_file()]"
	fdel(full_path)
	text2file(json_encode(loaded_data),full_path)