/client/verb/pm(var/k as null|anything in all_clients, var/text_to_say as text)

	set name = "PM"
	set category = "Communication"

	var/client/C = all_clients[k]

	if(!text_to_say || !C)
		return FALSE

	if(!check_spam(src))
		return FALSE

	text_to_say = police_input(src,text_to_say)

	if(!check_spam(src,text_to_say))
		return FALSE

	if(!text_to_say)
		return FALSE

	to_chat(format_speech(src,src,text_to_say,TEXT_PM),CHAT_TYPE_PM)
	C.to_chat(format_speech(src,src,text_to_say,TEXT_PM),CHAT_TYPE_PM)

	return TRUE

/client/verb/ooc(var/text_to_say as text)
	set name = "OOC"
	set category = "Communication"

	if(!text_to_say)
		return FALSE

	if(!check_spam(src))
		return FALSE

	text_to_say = police_input(src,text_to_say)

	if(!check_spam(src,text_to_say))
		return FALSE

	if(!text_to_say)
		return FALSE

	talk(src,src,text_to_say,TEXT_OOC)