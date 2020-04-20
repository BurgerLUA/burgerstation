/mob/verb/say(var/text_to_say as text)
	set hidden = TRUE
	do_say(text_to_say)

/mob/proc/do_say(var/text_to_say)

	if(!text_to_say)
		text_to_say = input("What would you like to say?","Say") as text|null

	if(!text_to_say)
		return FALSE

	if(client && !check_spam(client))
		return FALSE

	text_to_say = police_input(text_to_say)

	if(client && !check_spam(client,text_to_say))
		to_chat(span("warning","You are out of breath!"))
		return FALSE

	if(!length(text_to_say))
		return FALSE

	var/first_character = copytext(text_to_say,1,2)
	if(first_character == "/" || first_character == "!") //OOC
		if(client)
			var/client/C = client
			var/final_command = trim(copytext(text_to_say,2,0))
			winset(C, null, "command='[final_command]'")
			return text_to_say

	text_to_say = mod_speech(text_to_say)



	var/language_to_use = LANGUAGE_BASIC
	var/frequency_to_use = null
	var/talk_type_to_use = TEXT_TALK

	if(first_character == ";" || first_character == "." || first_character == ",")
		if(client && (first_character == "." || first_character == ","))
			var/old_first = first_character
			text_to_say = copytext(text_to_say,2,0)
			first_character = copytext(text_to_say,1,2)
			if(old_first == "," && client.macros.language_keys[first_character])
				language_to_use = client.macros.language_keys[first_character]
				text_to_say = copytext(text_to_say,2,0)
			else if(old_first == "." && client.macros.radio_keys[first_character])
				frequency_to_use = client.macros.radio_keys[first_character]
				text_to_say = copytext(text_to_say,2,0)
		else if(first_character == ";")
			frequency_to_use = -1
			text_to_say = trim(copytext(text_to_say,2,0))
			first_character = copytext(text_to_say,1,2)
			if(client && (first_character == "," || first_character == "."))
				text_to_say = copytext(text_to_say,2,0)
				first_character = copytext(text_to_say,1,2)
				if(first_character != " ")
					if(client.macros.language_keys[first_character])
						language_to_use = client.macros.language_keys[first_character]
						text_to_say = copytext(text_to_say,2,0)

	if(has_suffix(text_to_say,"!"))
		talk_type_to_use = TEXT_YELL

	text_to_say = trim(text_to_say)

	if(frequency_to_use)
		talk_type_to_use = TEXT_RADIO

	talk(src,src,text_to_say,talk_type_to_use,frequency_to_use,language_to_use)

	return text_to_say

/mob/living/do_say(var/text_to_say as text)

	if(dead)
		to_chat(span("warning","You can't talk while you're dead!"))
		return FALSE

	return ..()

/mob/living/advanced/do_say(var/text_to_say as text)

	start_typing()

	. = ..()

	end_typing()

	if(.)
		do_type(TALK_TYPE_EXCLAIMATION)

	return .

/mob/verb/emote(var/emote_id as text)
	set hidden = TRUE
	//do stuff

/mob/verb/whisper(var/text_to_say as text)
	set hidden = TRUE
	//do stuff

/mob/verb/looc(var/text_to_say as text)

	set name = "LOOC"
	set category = "Communication"

	if(client && !check_spam(client))
		return FALSE

	if(!text_to_say)
		return FALSE

	text_to_say = police_input(text_to_say)

	if(client && !check_spam(client,text_to_say))
		return FALSE

	talk(src,src,text_to_say,TEXT_LOOC)