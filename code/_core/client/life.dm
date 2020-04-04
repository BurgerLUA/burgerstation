/client/proc/on_life()

	spam_protection_chat = max(0,spam_protection_chat-1)

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


	return TRUE


/client/proc/on_life_slow()

	if(!mob)
		return TRUE

	for(var/image/I in stored_hud_images)
		images -= I
		stored_hud_images -= I

	if(mob.vision)
		for(var/mob/living/L in view(mob,VIEW_RANGE*0.5))
			if(mob.vision & FLAG_VISION_MEDICAL && L.medical_hud_image)
				stored_hud_images += L.medical_hud_image
				images += L.medical_hud_image
			if(mob.vision & FLAG_VISION_SECURITY && L.security_hud_image)
				stored_hud_images += L.security_hud_image
				images += L.security_hud_image
			if(mob.vision & FLAG_VISION_MEDICAL_ADVANCED && L.medical_hud_image_advanced)
				stored_hud_images += L.medical_hud_image_advanced
				images += L.medical_hud_image_advanced


	return TRUE