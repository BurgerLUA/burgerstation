/mob/living/do_say(text_to_say, should_sanitize = TRUE, talk_type_to_use = TEXT_TALK,talk_range=TALK_RANGE,language_to_use=null)

	if(dead)
		if(!client) return FALSE
		talk_type_to_use = TEXT_GHOST
		return ..()

	start_typing()

	. = ..()

	end_typing()

	if(.)
		do_type(TALK_TYPE_EXCLAIMATION)

/mob/living/proc/do_type(type_type)
	talk_duration = 4 SECONDS
	if(chat_overlay)
		chat_overlay.icon_state = type_type
		//chat_overlay.pixel_x = pixel_x
		//chat_overlay.pixel_y = pixel_y
		//chat_overlay.pixel_z = pixel_z
		chat_overlay.alpha = 255

/mob/living/proc/start_typing()
	is_typing = TRUE
	if(chat_overlay)
		chat_overlay.icon_state = "talking"
		//chat_overlay.pixel_x = pixel_x
		//chat_overlay.pixel_y = pixel_y
		//chat_overlay.pixel_z = pixel_z
		chat_overlay.alpha = 255

/mob/living/proc/end_typing()
	is_typing = FALSE
	if(chat_overlay)
		chat_overlay.icon_state = "none"
