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

/mob/verb/say(var/text_to_say as text)

	set name = "Say"
	set category = "Communication"

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
		if(src.client)
			var/client/C = src.client
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
		world.log << "Using frequency [frequency_to_use]."
		if(talk_type_to_use == TEXT_TALK)
			talk_type_to_use = TEXT_WHISPER
		else if(talk_type_to_use == TEXT_YELL)
			talk_type_to_use = TEXT_TALK
		talk(src,src,text_to_say,talk_type_to_use, language = language_to_use)
		for(var/obj/item/device/radio/R in all_radios)
			if(get_turf(R) != get_turf(src))
				continue
			if(frequency_to_use == -1)
				frequency_to_use = R.frequency
			visible_message(span("notice","\The [src.name] speaks into \the [R.name]."),span("notice","You speak into \the [R.name]."))
			R.send_data(list("speaker" = src, "source" = src, "message" = text_to_say, "language" = language_to_use, "frequency" = frequency_to_use))
			break
	else
		talk(src,src,text_to_say,talk_type_to_use,language = language_to_use)

	/*
	//Shitcode ahoy.
	if(first_character == ";")
		for(var/obj/item/device/radio/R in all_radios)
			if(get_turf(R) != get_turf(src))
				continue
			visible_message(span("notice","\The [src.name] speaks into \the [R.name]."),span("notice","You speak into \the [R.name]."))
			text_to_say = trim(copytext(text_to_say,2,0))
			first_character = length(text_to_say) >= 1 ? copytext(text_to_say,1,2) : null
			var/second_character = length(text_to_say) >= 2 ? copytext(text_to_say,2,3) : null
			if(first_character == "." && client.macros.language_keys[second_character])
				text_to_say = trim(copytext(text_to_say,2,0))
				talk(src,src,text_to_say,TEXT_WHISPER,language = client.macros.language_keys[second_character])
				R.send_data(list("speaker" = src, "source" = src, "message" = text_to_say, "language" = client.macros.language_keys[second_character]))
			else
				talk(src,src,text_to_say,TEXT_WHISPER)
				R.send_data(list("speaker" = src, "source" = src, "message" = text_to_say))
			break
	else if(client && client.macros && first_character == "." && length(text_to_say) >= 4)
		var/third_character = copytext(text_to_say,3,4)
		if(third_character == " ")
			var/second_character = copytext(text_to_say,2,3)
			if(client.macros.radio_keys[second_character])
				var/desired_frequency = client.macros.radio_keys[second_character]
				for(var/obj/item/device/radio/R in all_radios)
					if(get_turf(R) != get_turf(src))
						continue
					text_to_say = trim(copytext(text_to_say,4,0))
					visible_message(span("notice","\The [src.name] speaks into \the [R.name]."),span("notice","You speak into \the [R.name]."))
					talk(src,src,text_to_say,TEXT_WHISPER)
					R.send_data(list("speaker" = src, "source" = src, "message" = text_to_say, "frequency" = desired_frequency))
					break
			else if(client.macros.language_keys[second_character])
				talk(src,src,text_to_say,TEXT_TALK,language = client.macros.language_keys[second_character])
				return text_to_say
	else
		talk(src,src,text_to_say,TEXT_TALK)
	*/

	return text_to_say

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

/mob/proc/to_chat(var/text,var/chat_type = CHAT_TYPE_INFO)

	if(client)
		client.to_chat(text,chat_type)
		return TRUE

	return FALSE


/mob/proc/to_chat_language(var/text, var/chat_type=CHAT_TYPE_INFO, var/language = LANGUAGE_BASIC, var/language_text = "Blah blah blah.")
	if(!length(known_languages) || !known_languages[language])
		return to_chat(language_text,chat_type)
	return to_chat(text,chat_type)


