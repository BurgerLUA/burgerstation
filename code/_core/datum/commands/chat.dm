/mob/verb/say(var/text_to_say as text)
	set hidden = TRUE
	do_say(text_to_say)

/mob/proc/do_say(var/text_to_say,var/should_sanitize=TRUE)

	if(!text_to_say)
		text_to_say = input("What would you like to say?","Say") as text|null

	if(!text_to_say)
		return FALSE

	if(client && !check_spam(client))
		return FALSE

	if(should_sanitize)
		text_to_say = police_input(text_to_say)

	if(client && !check_spam(client,text_to_say))
		to_chat(span("warning","You are out of breath!"))
		return FALSE

	if(!length(text_to_say))
		return FALSE

	var/first_character = copytext(text_to_say,1,2)
	if(first_character == "/" || first_character == "!") //OOC commands.
		if(client)
			var/client/C = client
			var/final_command = trim(copytext(text_to_say,2,0))
			winset(C, null, "command='[final_command]'")
			return text_to_say

	text_to_say = mod_speech(text_to_say)

	var/language_to_use = LANGUAGE_BASIC
	var/frequency_to_use = null
	var/talk_type_to_use = TEXT_TALK

	var/list/available_languages = list()
	if(client)
		for(var/letter_key in client.macros.language_keys)
			var/language_key = client.macros.language_keys[letter_key]
			if(!known_languages[language_key])
				continue
			available_languages[letter_key] = language_key
	//TODO: MAKE IT SO THAT NPCS CAN USE LANGUAGES HERE.


	if(first_character == "." || first_character == ",")
		var/old_first = first_character
		text_to_say = copytext(text_to_say,2,0)
		first_character = copytext(text_to_say,1,2)
		if(old_first == ",")
			if(available_languages[first_character])
				language_to_use = available_languages[first_character]
				text_to_say = copytext(text_to_say,2,0)
			else
				to_chat(span("warning","You don't know that language!"))
				return FALSE
		else if(client && old_first == ".")
			if(client.macros.radio_keys[first_character])
				frequency_to_use = client.macros.radio_keys[first_character]
				text_to_say = copytext(text_to_say,2,0)
			else
				to_chat(span("warning","You don't have that radio key!"))
				return FALSE
	else if(first_character == ";") //Common radio.
		frequency_to_use = -1
		text_to_say = trim(copytext(text_to_say,2,0))
		first_character = copytext(text_to_say,1,2)
		if(client && first_character == ",")
			text_to_say = copytext(text_to_say,2,0)
			first_character = copytext(text_to_say,1,2)
			if(first_character != " ")
				if(available_languages[first_character])
					language_to_use = available_languages[first_character]
					text_to_say = copytext(text_to_say,2,0)
				else
					to_chat(span("warning","You don't know that language!"))
					return FALSE

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