/client/verb/ooc(var/text_to_say as text)

	if(!text_to_say)
		return FALSE

	if(!check_spam(src))
		return FALSE

	text_to_say = police_input(text_to_say)

	if(!check_spam(src,text_to_say))
		return FALSE

	display_message(src,src,text_to_say,TEXT_OOC)


/client/proc/to_chat(var/text,var/chat_type)

	if(!text || !chat_type)
		return FALSE

	var/output_target_list = list()

	if(!(chat_type & CHAT_TYPE_COMBAT))
		output_target_list += "chat_all.output"

	if(chat_type & CHAT_TYPE_SAY)
		output_target_list += "chat_say.output"

	if(chat_type & CHAT_TYPE_OOC)
		output_target_list += "chat_ooc.output"

	if(chat_type & CHAT_TYPE_LOOC)
		output_target_list += "chat_looc.output"

	if(chat_type & CHAT_TYPE_COMBAT)
		output_target_list += "chat_combat.output"

	if(chat_type & CHAT_TYPE_RADIO) //Prevents radio spam if you heard it already.
		for(var/list/message_data in queued_chat_messages)
			if(message_data["text"] == text)
				return FALSE

	queued_chat_messages.Add(
		list(
			list(
				"text" = text,
				"output_target_list" = output_target_list
			)
		)
	)

	return TRUE


/client/verb/pm(var/client/C as null|anything in all_clients, var/text_to_say as text)

	if(!text_to_say || !C)
		return FALSE

	if(!check_spam(src))
		return FALSE

	text_to_say = police_input(text_to_say)

	if(!check_spam(src,text_to_say))
		return FALSE

	to_chat(format_speech(src,src,text_to_say,TEXT_PM),CHAT_TYPE_PM)
	C.to_chat(format_speech(src,src,text_to_say,TEXT_PM),CHAT_TYPE_PM)

	return TRUE
