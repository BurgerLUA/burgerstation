/savedata/client/settings
	loaded_data = list(
		"volume_master" = 70,
		"volume_fx" = 70,
		"volume_ambient" = 50,
		"volume_music" = 50,
		"volume_footsteps" = 50,
		"fps_client" = FPS_CLIENT,
		"hud_colors" = DEFAULT_COLORS
	)

/savedata/client/settings/get_file(var/file_id)
	return "settings.json"

/savedata/client/settings/New(var/client/new_owner)

	. = ..()

	owner = new_owner

	var/full_path = "[get_folder(ckey)][get_file()]"

	if(!fexists(full_path))
		text2file(json_encode(loaded_data),full_path)

	var/file_contents = file2text(full_path)
	loaded_data = json_decode(file_contents)
	if(loaded_data["fps_client"])
		new_owner.fps = loaded_data["fps_client"]

	if(owner.mob)
		for(var/obj/hud/button/B in owner.mob.buttons)
			B.update_sprite()

		for(var/obj/hud/button/B in owner.mob.health_elements)
			B.update_sprite()

		if(is_advanced(owner))
			var/mob/living/advanced/A = owner.mob
			for(var/obj/hud/inventory/I in A.inventory)
				I.update_sprite()

	owner.update_window()

	return .

/savedata/client/settings/proc/change_setting(var/setting_id,var/setting_value)
	loaded_data[setting_id] = setting_value
	save()
	return TRUE

/savedata/client/settings/proc/save()
	var/full_path = "[get_folder(ckey)][get_file()]"
	owner.mob.to_chat(span("notice","Your settings have been saved."))
	fdel(full_path)
	text2file(json_encode(loaded_data),full_path)