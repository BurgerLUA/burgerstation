/client/proc/on_life()

	spam_protection_chat = max(0,spam_protection_chat - TICKS_TO_DECISECONDS(CLIENT_TICK))

	if(queued_chat_messages && length(queued_chat_messages) && queued_chat_messages[1])

		var/list/queued_message = queued_chat_messages[1]
		var/text = queued_message["text"]
		var/list/targets = queued_message["output_target_list"]

		for(var/target in targets)
			src << output(text,target)

		queued_chat_messages.Cut(1,2)

	//ping()

	if(mob)
		mob.on_life_client()


	handle_camera()

	/*
	if(is_zoomed)
		var/list/dir_to_pixel = direction_to_pixel_offset(mob.dir)
		pixel_x += clamp(dir_to_pixel[1]*TILE_SIZE*ZOOM_RANGE - pixel_x,-8,8)
		pixel_y += clamp(dir_to_pixel[2]*TILE_SIZE*ZOOM_RANGE - pixel_y,-8,8)
	else
		pixel_x -= clamp(pixel_x,-12,12)
		pixel_y -= clamp(pixel_y,-12,12)
	*/

	return TRUE

/client/proc/on_life_slow()

	if(!mob)
		return TRUE

	for(var/image/I in stored_hud_images)
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

	/*
	if(is_zoomed)

		var/list/params_list = params2list(last_params)
		var/list/screen_loc = parse_screen_loc(params_list["screen-loc"])

		animate(
			src,
			pixel_x = clamp( (screen_loc[1] - VIEW_RANGE*TILE_SIZE)*3, -ZOOM_RANGE*TILE_SIZE, ZOOM_RANGE*TILE_SIZE),
			pixel_y = clamp( (screen_loc[2] - VIEW_RANGE*TILE_SIZE)*3, -ZOOM_RANGE*TILE_SIZE, ZOOM_RANGE*TILE_SIZE),
			time = TICKS_TO_DECISECONDS(CLIENT_TICK_SLOW)
		)

		if(mob)
			mob.face_atom(last_location)
	*/

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