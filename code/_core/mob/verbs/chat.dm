/mob/verb/say(var/text_to_say as text)
	set hidden = TRUE
	do_say(text_to_say)

/mob/verb/emote(var/emote as text,var/mob/target in view)
	set name = "Emote"
	set category = "Communication"
	do_emote(text,target)

/mob/verb/me(var/emote_text as text)
	set name = "Me"
	set category = "Communication"

	if(client && !check_spam(client))
		return FALSE

	if(!emote_text)
		emote_text = input("What would you like to emote?","Me") as message

	if(!emote_text)
		return FALSE

	if(client && !check_spam(client,emote_text))
		return FALSE

	visible_message("\The <b>[src.name]</b> [emote_text]")

/mob/verb/whisper(var/text_to_say as text)
	set name = "Whisper"
	set category = "Communication"

	if(client && !check_spam(client))
		return FALSE

	do_say(text_to_say,talk_range = WHISPER_RANGE)

/mob/verb/looc(var/text_to_say as text)

	set name = "LOOC"
	set category = "Communication"

	if(client && !check_spam(client))
		return FALSE

	if(!text_to_say)
		return FALSE

	if(src.client)
		text_to_say = police_input(src.client,text_to_say)

	if(!check_spam(client,text_to_say))
		return FALSE

	if(!text_to_say)
		return FALSE

	talk(src,src,text_to_say,TEXT_LOOC)