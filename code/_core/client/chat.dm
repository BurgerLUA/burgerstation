/client/proc/to_chat(var/text,var/chat_type)
	text = "<div class='message'>[text]</div>"

	if(!(chat_type & CHAT_TYPE_COMBAT))
		src << output(text,"chat_all.output")

	if(chat_type & CHAT_TYPE_SAY)
		src << output(text,"chat_say.output")

	if(chat_type & CHAT_TYPE_OOC)
		src << output(text,"chat_ooc.output")

	if(chat_type & CHAT_TYPE_LOOC)
		src << output(text,"chat_looc.output")

	if(chat_type & CHAT_TYPE_COMBAT)
		src << output(text,"chat_combat.output")