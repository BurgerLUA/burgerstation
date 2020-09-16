/client/proc/on_life()

	spam_protection_chat = max(0,spam_protection_chat - TICKS_TO_DECISECONDS(CLIENT_TICK))
	spam_protection_interact = max(0,spam_protection_interact - TICKS_TO_DECISECONDS(CLIENT_TICK))

	if(queued_chat_messages && length(queued_chat_messages) && queued_chat_messages[1])

		var/list/queued_message = queued_chat_messages[1]
		var/text = queued_message["text"]
		var/list/targets = queued_message["output_target_list"]

		for(var/target in targets)
			src << output(text,target)

		queued_chat_messages.Cut(1,2)

	if(mob) mob.on_life_client()

	handle_camera()

	return TRUE

/client/proc/on_life_slow()

	if(!mob)
		return TRUE

	for(var/k in stored_hud_images)
		var/image/I = k
		images -= I
		stored_hud_images -= I

	if(mob.vision)
		for(var/mob/living/L in view(mob,VIEW_RANGE*0.5))
			if(mob.vision & FLAG_VISION_MEDICAL && L.medical_hud_image && L.alpha >= 255)
				stored_hud_images += L.medical_hud_image
				images += L.medical_hud_image
			if(mob.vision & FLAG_VISION_SECURITY && L.security_hud_image && L.alpha >= 255)
				stored_hud_images += L.security_hud_image
				images += L.security_hud_image
			if(mob.vision & FLAG_VISION_MEDICAL_ADVANCED && L.medical_hud_image_advanced && L.alpha >= 255)
				stored_hud_images += L.medical_hud_image_advanced
				images += L.medical_hud_image_advanced

	update_color_mods()

	return TRUE


/client/proc/set_zoom(var/desired_zoom)
	is_zoomed = desired_zoom
	/*
	if(desired_zoom)
		var/list/dir_to_pixel = direction_to_pixel_offset(mob.dir)
		animate(src,pixel_x = dir_to_pixel[1]*TILE_SIZE*VIEW_RANGE, pixel_y = dir_to_pixel[2]*TILE_SIZE*VIEW_RANGE, time = SECONDS_TO_DECISECONDS(1), flags = ANIMATION_LINEAR_TRANSFORM )
	else
		animate(src,pixel_x = 0, pixel_y = 0, time = SECONDS_TO_DECISECONDS(0.5), flags = ANIMATION_LINEAR_TRANSFORM )
	*/
	return TRUE