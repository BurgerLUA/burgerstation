/proc/check_spam(var/client/C,var/text_to_check)

	if(!text_to_check)
		C.spam_protection_chat += 1

	if(C.spam_protection_chat > 2)
		C.to_chat(span("warning","You can't talk this fast!"))
		return FALSE

	if(text_to_check)
		C.spam_protection_chat = min(C.spam_protection_chat+2+(length(text_to_check)*0.1),100) * (C.last_message == text_to_check ? 3 : 1)
		C.last_message = text_to_check

	return TRUE

/mob/proc/mod_speech(var/text)
	return text

/mob/living/mod_speech(var/text)

	if(intoxication >= 300)
		var/list/exploded_words = splittext(text," ")
		var/final_text = ""
		for(var/word in exploded_words)
			if(prob(intoxication/100))
				word = "*BURP*"
			else if(prob(intoxication/100))
				word = "*HICCUP*"
			else if(length(word) > 2 && prob(intoxication/10))
				var/list/exploded_letters = splittext(word,"")
				var/min = 1
				var/max = exploded_letters-1
				var/choice = rand(min,max)
				exploded_letters.Swap(choice,choice+1)
				word = jointext(exploded_letters,"")
			else if(prob(intoxication/20))
				vowels.Replace(word,"")

			if(prob(intoxication/20))
				word = "[word] uhhh..."

			final_text += "[word] "

		text = trim(final_text)

	return ..(text)

/mob/living/advanced/mod_speech(var/text)
	var/species/S = all_species[species]
	if(!S)
		return text
	return ..(S.mod_speech(src,text))

/mob/proc/to_chat(var/text,var/chat_type = CHAT_TYPE_INFO)

	if(client)
		client.to_chat(text,chat_type)
		return TRUE

	return FALSE

/mob/proc/to_chat_language(var/text, var/chat_type=CHAT_TYPE_INFO, var/language = LANGUAGE_BASIC, var/language_text = "Blah blah blah.")
	if(!length(known_languages) || !known_languages[language])
		return to_chat(language_text,chat_type)
	return to_chat(text,chat_type)


/mob/proc/do_say(var/text_to_say, var/should_sanitize = TRUE, var/talk_type_to_use = TEXT_TALK)

	if(client && !check_spam(client))
		return FALSE

	if(!text_to_say)
		text_to_say = input("What would you like to say?","Say") as text|null

	if(!text_to_say)
		return FALSE

	if(client && !check_spam(client,text_to_say))
		to_chat(span("warning","You are out of breath!"))
		return FALSE

	if(!text_to_say)
		return FALSE

	if(!length(text_to_say))
		return FALSE

	text_to_say = copytext(text_to_say,1,MAX_MESSAGE_LEN)

	var/first_character = copytext(text_to_say,1,2)
	//var/last_character = copytext(text_to_say,-1,0)

	if(first_character == "/" || first_character == "!") //OOC commands.
		if(client)
			var/client/C = client
			var/final_command = trim(copytext(text_to_say,2,0))
			winset(C, null, "command='[final_command]'")
			return text_to_say
	else if(first_character == "*") //Emote
		var/final_emote = trim(copytext(text_to_say,2,0))
		do_emote(final_emote)
		return TRUE

	var/language_to_use = LANGUAGE_BASIC
	var/frequency_to_use = null

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

	else if(has_suffix(text_to_say,"!"))
		talk_type_to_use = TEXT_YELL

	if(frequency_to_use)
		talk_type_to_use = TEXT_RADIO

	text_to_say = trim(mod_speech(text_to_say))

	if(should_sanitize && src.client)
		text_to_say = police_input(src.client,text_to_say)

	talk(src,src,text_to_say,talk_type_to_use,frequency_to_use,language_to_use)

	return text_to_say

/mob/proc/do_emote(var/emote_text,var/atom/target,var/messages = TRUE)

	if(!emote_text)
		return FALSE

	if(!(emote_text in known_emotes))
		if(messages) to_chat("Invalid emote!")
		return FALSE

	if(!SSemote.all_emotes[emote_text])
		if(messages) to_chat("Unknown emote: \"[emote_text]\".")
		return FALSE

	var/emote/E = SSemote.all_emotes[emote_text]
	E.on_emote(src,target)

	return TRUE

/mob/living/do_emote(var/emote_text,var/atom/target)

	if(dead)
		return FALSE

	return ..()