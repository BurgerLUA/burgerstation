/savedata/client/settings
	loaded_data = list(
		"volume_master" = 70,
		"volume_fx" = 70,
		"volume_ambient" = 50,
		"volume_music" = 50,
		"volume_footsteps" = 50,
		"view_range" = VIEW_RANGE,
		"fps_client" = FPS_CLIENT,
		"hud_colors" = DEFAULT_COLORS
	)

/savedata/client/settings/get_file(var/file_id)
	return "settings.json"

/savedata/client/settings/New(var/desired_ckey)

	. = ..()

	var/client/owner = CLIENT(ckey)

	var/full_path = "[get_folder(ckey)][get_file()]"

	if(!fexists(full_path))
		rustg_file_append(json_encode(loaded_data),full_path)

	var/file_contents = rustg_file_read(full_path)
	loaded_data = json_decode(file_contents)
	if(loaded_data["fps_client"])
		owner.fps = loaded_data["fps_client"]

	if(owner.mob)
		for(var/k in owner.mob.buttons)
			var/obj/hud/button/B = k
			B.update_sprite()

		for(var/k in owner.mob.health_elements)
			var/obj/hud/button/B = owner.mob.health_elements[k]
			B.update_sprite()

		if(is_advanced(owner))
			var/mob/living/advanced/A = owner.mob
			for(var/k in A.inventory)
				var/obj/hud/inventory/I = k
				I.update_sprite()

	owner.update_window()

	return .

/savedata/client/settings/proc/change_setting(var/setting_id,var/setting_value)
	loaded_data[setting_id] = setting_value
	save()
	return TRUE

/savedata/client/settings/proc/save()
	var/client/owner = CLIENT(ckey)
	var/full_path = "[get_folder(ckey)][get_file()]"
	owner.mob.to_chat(span("notice","Your settings have been saved."))
	rustg_file_write(json_encode(loaded_data),full_path)