/mob/living/do_say(var/text_to_say, var/should_sanitize = TRUE, var/talk_type_to_use = TEXT_TALK)

	if(dead)
		to_chat(span("warning","You can't talk while you're dead!"))
		return FALSE

	start_typing()

	. = ..()

	end_typing()

	if(.)
		do_type(TALK_TYPE_EXCLAIMATION)

	return .


/mob/living/proc/do_type(var/type_type)
	talk_duration = SECONDS_TO_DECISECONDS(4)
	chat_overlay.icon_state = type_type
	chat_overlay.pixel_x = pixel_x
	chat_overlay.pixel_y = pixel_y
	chat_overlay.pixel_z = pixel_z
	chat_overlay.alpha = 255

/mob/living/proc/start_typing()
	is_typing = TRUE
	chat_overlay.icon_state = "talking"
	chat_overlay.pixel_x = pixel_x
	chat_overlay.pixel_y = pixel_y
	chat_overlay.pixel_z = pixel_z
	chat_overlay.alpha = 255

/mob/living/proc/end_typing()
	is_typing = FALSE
	chat_overlay.icon_state = "none"