/client/verb/pm(k as null|anything in SSclient.all_clients, text_to_say as text)

	set name = "PM"
	set category = "Communication"

	var/client/C = SSclient.all_clients[k]

	if(!text_to_say || !C)
		return FALSE

	if(!check_spam(src))
		return FALSE

	text_to_say = police_text(src,text_to_say,check_characters=TRUE)

	if(!check_spam(src,text_to_say))
		return FALSE

	if(!text_to_say)
		return FALSE

	to_chat(format_speech(src,src,text_to_say,TEXT_PM),CHAT_TYPE_PM)
	C.to_chat(format_speech(src,src,text_to_say,TEXT_PM),CHAT_TYPE_PM)

	return TRUE

/client/verb/ooc(text_to_say as text)
	set name = "OOC"
	set category = "Communication"

	if(!text_to_say)
		return FALSE

	if(is_living(mob))
		var/mob/living/L = mob
		if(L.dead)
			to_chat(span("warning","You cannot use OOC when dead."))
			return FALSE

	if(!check_spam(src))
		return FALSE

	text_to_say = police_text(src,text_to_say,check_characters=TRUE)

	if(!check_spam(src,text_to_say))
		return FALSE

	if(!text_to_say)
		return FALSE

	talk(src,src,text_to_say,TEXT_OOC)