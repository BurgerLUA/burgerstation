/proc/check_spam(var/client/C,var/text_to_check)

	if(!text_to_check)
		C.spam_protection_chat = min(C.spam_protection_chat+2,5)

	if(C.spam_protection_chat > 2)
		C.to_chat(span("warning","You can't talk this fast!"))
		return FALSE

	if(text_to_check)
		C.spam_protection_chat = min(C.spam_protection_chat+1+(length(text_to_check)*0.01),10)

	return TRUE


/mob/living/say(var/text_to_say as text)

	if(dead)
		to_chat(span("warning","You can't talk while you're dead!"))
		return FALSE

	return ..()

/mob/living/advanced/say(var/text_to_say as text)

	start_typing()

	. = ..()

	end_typing()

	if(.)
		do_type(TALK_TYPE_EXCLAIMATION)

	return .

/mob/proc/mod_speech(var/text)
	return text

/mob/living/advanced/mod_speech(var/text)
	var/species/S = all_species[species]
	if(!S)
		return text
	return S.mod_speech(src,text)

/mob/proc/to_chat(var/text,var/chat_type = CHAT_TYPE_INFO)

	if(client)
		client.to_chat(text,chat_type)
		return TRUE

	return FALSE


/mob/proc/to_chat_language(var/text, var/chat_type=CHAT_TYPE_INFO, var/language = LANGUAGE_BASIC, var/language_text = "Blah blah blah.")
	if(!length(known_languages) || !known_languages[language])
		return to_chat(language_text,chat_type)
	return to_chat(text,chat_type)


