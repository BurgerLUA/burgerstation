/mob/verb/say(var/text_to_say as text)

	if(spam_protection_say >= 1)
		to_chat(span("warning","You are out of breath! Please wait [spam_protection_say - 1] seconds before speaking again!"))
		return FALSE

	if(is_advanced(src))
		var/mob/living/advanced/A = src
		A.start_typing()

	if(!text_to_say)
		text_to_say = input("What would you like to say?")

	if(text_to_say)
		display_message(src,text_to_say,TEXT_TALK)
		if(is_advanced(src))
			var/mob/living/advanced/A = src
			A.do_type(TALK_TYPE_EXCLAIMATION)

	if(is_advanced(src))
		var/mob/living/advanced/A = src
		A.end_typing()

	spam_protection_say += max(0.25,lentext(text_to_say)*0.01)

	return TRUE

/mob/verb/emote(var/emote_id as text)
	//do stuff


/mob/verb/whisper(var/text_to_say as text)
	//do stuff



/mob/verb/looc(var/text_to_say as text)
	display_message(src,text_to_say,TEXT_LOOC)

/mob/proc/to_chat(var/text,var/chat_type = CHAT_TYPE_INFO)

	if(client)
		client.to_chat(text,chat_type)
		return TRUE

	return FALSE