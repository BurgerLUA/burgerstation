mob/living/advanced/proc/set_chat_text(var/text_to_say)
	if(chat_text)
		chat_text.set_map_text(text_to_say)

	return TRUE