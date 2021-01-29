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

var/regex/vowels = new("\[aeiou\]", "i")

/mob/living/mod_speech(var/text)

	if(intoxication >= 200)
		var/list/exploded_words = splittext(text," ")
		var/final_text = ""
		for(var/word in exploded_words)
			if(prob(intoxication/150))
				word = "*HICCUP* [word]"
			else if(prob(intoxication/200))
				word = "*BURP*"
			else if(length(word) > 3 && prob(intoxication/10))
				var/list/exploded_letters = splittext(word,"")
				var/min = 2
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

	return ..()

/mob/proc/to_chat(var/text,var/chat_type = CHAT_TYPE_INFO)

	if(client)
		client.to_chat(text,chat_type)
		return TRUE

	return FALSE

/proc/tooltip(var/text,var/tooltip)
	if(!tooltip)
		return text
	return div("tooltip","[text][div("tooltip_text",tooltip)]")

/*
/mob/proc/to_chat_language(var/text, var/chat_type=CHAT_TYPE_INFO, var/language = LANGUAGE_BASIC, var/language_text = "Blah blah blah.")
	if(!length(known_languages) || !known_languages[language])
		return to_chat(language_text,chat_type)
	return to_chat(tooltip(text,language_text),chat_type)
*/


/mob/do_say(var/text_to_say, var/should_sanitize = TRUE, var/talk_type_to_use = TEXT_TALK,var/talk_range=TALK_RANGE,var/language_to_use=null)

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

	var/list/available_languages = list()

	if(!language_to_use)
		language_to_use = LANGUAGE_BASIC
		if(client)
			for(var/letter_key in client.macros.language_keys)
				var/language_key = client.macros.language_keys[letter_key]
				if(!known_languages[language_key])
					continue
				available_languages[letter_key] = language_key

	var/frequency_to_use = null

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
		talk_range = YELL_RANGE

	if(frequency_to_use && talk_type_to_use == TEXT_TALK)
		talk_type_to_use = TEXT_RADIO

	text_to_say = trim(mod_speech(text_to_say))

	if(should_sanitize && src.client)
		text_to_say = police_input(src.client,text_to_say)

	talk(src,src,text_to_say,talk_type_to_use,frequency_to_use,language_to_use,talk_range)

	return text_to_say

/mob/proc/do_emote(var/emote_text,var/atom/target,var/messages = TRUE)

	if(world.time <= next_emote)
		return FALSE

	if(!emote_text)
		return FALSE

	if(!(emote_text in known_emotes))
		if(messages) to_chat(span("warning","Invalid emote: \"[emote_text]\"!"))
		return FALSE

	if(!SSemote.all_emotes[emote_text])
		if(messages) to_chat(span("warning","Unknown emote: \"[emote_text]\"."))
		return FALSE

	var/emote/E = SSemote.all_emotes[emote_text]
	E.on_emote(src,target)

	next_emote = world.time + 5

	return TRUE

/mob/living/do_emote(var/emote_text,var/atom/target)

	if(dead)
		return FALSE

	return ..()


/mob/on_listen(var/atom/speaker,var/datum/source,var/text,var/language_text,var/talk_type,var/frequency, var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE)

	if(client)
		var/knows_language = length(known_languages) && known_languages[language]
		var/formatted_speech
		if(!knows_language && language_text)
			formatted_speech = format_speech(speaker,source,language_text,talk_type,frequency,language,talk_range,knows_language)
		else
			formatted_speech = format_speech(speaker,source,text,talk_type,frequency,language,talk_range,knows_language)
		to_chat(formatted_speech,CHAT_TYPE_SAY) //Ears are in game. NEVER CHANGE CHAT_TYPE_SAY OR ELSE YOU'LL SPEND 1 HOUR DEBUGGING THIS LIKE I DID.

	return ..()