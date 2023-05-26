/savedata/client/settings
	loaded_data = list(
		"volume_master" = 70,
		"volume_fx" = 70,
		"volume_ambient" = 50,
		"volume_music" = 50,
		"volume_footsteps" = 50,
		"view_range" = VIEW_RANGE,
		"fps_client" = FPS_CLIENT,
		"hud_colors" = DEFAULT_COLORS,
		"enable_zoom_view_lock" = 0,
		"enable_depth" = 1,
		"enable_smooth_shadows" = 1,
		"enable_currency_bloom" = 1,
		"enable_old_right_click" = 1,
		"compact_mode" = 0,
		"show_admin_messages" = 1,
		"show_debug_messages" = 1
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
			for(var/k in A.inventories_by_id)
				var/obj/hud/inventory/I = A.inventories_by_id[k]
				I.update_sprite()

	owner.update_window()

/savedata/client/settings/proc/change_setting(var/setting_id,var/setting_value)
	loaded_data[setting_id] = setting_value
	save()
	return TRUE

/savedata/client/settings/proc/save()
	var/client/owner = CLIENT(ckey)
	var/full_path = "[get_folder(ckey)][get_file()]"
	rustg_file_write(json_encode(loaded_data),full_path)
	owner.mob.to_chat(span("notice","Your settings have been saved."))