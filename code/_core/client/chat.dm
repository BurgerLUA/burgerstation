/client/verb/ooc(var/text_to_say as text)

	if(check_spam(src))
		return FALSE

	if(!text_to_say)
		text_to_say = input("What would you like to say?") as text|null
		if(!text_to_say)
			return

	if(last_ooc+10 >= curtime)
		src.to_chat(span("warning","You're using OOC too fast!"))
		return FALSE

	display_message(src,src,text_to_say,TEXT_OOC)
	last_ooc = curtime

/client/proc/to_chat(var/text,var/chat_type)

	text = "<div class='message'>[text]</div>"

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

	queued_chat_messages.Add(list(list("text" = text,"output_target_list" = output_target_list)))

	return TRUE


/client/verb/pm(var/message as text)

	var/client/C = input("Who would you like to message?","Desired Client") as null|anything in all_clients
	if(!C)
		return

	to_chat(format_speech(src,src,message,TEXT_PM),CHAT_TYPE_PM)
	C.to_chat(format_speech(src,src,message,TEXT_PM),CHAT_TYPE_PM)
