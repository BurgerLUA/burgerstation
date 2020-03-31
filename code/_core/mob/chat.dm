/proc/check_spam(var/client/C,var/text_to_check)

	if(!text_to_check)
		C.spam_protection_chat = min(C.spam_protection_chat+2,5)

	if(C.spam_protection_chat > 2)
		C.to_chat(span("warning","You can't talk this fast!"))
		return FALSE

	if(text_to_check)
		C.spam_protection_chat = min(C.spam_protection_chat+1+(length(text_to_check)*0.01),10)

	return TRUE


/mob/living/advanced/say(var/text_to_say as text)


	start_typing()

	. = ..()

	end_typing()

	if(.)
		do_type(TALK_TYPE_EXCLAIMATION)

	return .

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

	if(length(text_to_say))
		var/first_character = copytext(text_to_say,1,2)
		if(first_character == "/" || first_character == "!")
			if(src.client)
				var/client/C = src.client
				var/final_command = trim(copytext(text_to_say,2,0))
				winset(C, null, "command='[final_command]'")
		else if(first_character == ";")
			for(var/obj/item/device/radio/R in all_radios)
				if(get_turf(R) != get_turf(src))
					continue
				var/final_command = trim(copytext(text_to_say,2,0))
				visible_message(span("notice","\The [src.name] speaks into \the [R.name]."),span("notice","You speak into \the [R.name]."))
				display_message(src,src,final_command,TEXT_WHISPER)
				R.send_data(list("speaker" = src, "source" = src, "message" = final_command))
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
						var/final_command = trim(copytext(text_to_say,4,0))
						visible_message(span("notice","\The [src.name] speaks into \the [R.name]."),span("notice","You speak into \the [R.name]."))
						display_message(src,src,final_command,TEXT_WHISPER)
						R.send_data(list("speaker" = src, "source" = src, "message" = final_command, "frequency" = desired_frequency))
						break
		else
			display_message(src,src,text_to_say,TEXT_TALK)

	return TRUE

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

	display_message(src,src,text_to_say,TEXT_LOOC)

/mob/proc/to_chat(var/text,var/chat_type = CHAT_TYPE_INFO)

	if(client)
		client.to_chat(text,chat_type)
		return TRUE

	return FALSE