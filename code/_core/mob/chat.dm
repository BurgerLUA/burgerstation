/mob/verb/say(var/text_to_say as text)

	if(!text_to_say)
		text_to_say = input("What would you like to say?")

	display_message(src,text_to_say,TEXT_TALK)

/mob/verb/looc(var/text_to_say as text)
	display_message(src,text_to_say,TEXT_LOOC)