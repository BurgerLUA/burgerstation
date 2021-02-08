/client/proc/to_chat(var/text,var/chat_type=CHAT_TYPE_INFO)

	if(!text || !chat_type)
		return FALSE

	if(!isnum(chat_type))
		CRASH("chat_type was not a number!")
		return FALSE

	if(!queued_chat_messages)
		log_error("Error: [src.get_debug_name()] didn't have a queued_chat_messages variable!")
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
		for(var/k in queued_chat_messages)
			var/list/message_data = k
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
