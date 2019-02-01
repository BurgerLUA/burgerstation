/mob/verb/say(var/text_to_say as text)

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

/mob/verb/looc(var/text_to_say as text)
	display_message(src,text_to_say,TEXT_LOOC)