/*
/proc/broadcast(var/text_to_say as text, var/text_type = TEXT_OOC)
	for(var/mob/object in world)
		object.to_chat(text_to_say)
*/

/proc/broadcast_to_clients(var/text_to_say as text, var/text_type = TEXT_OOC)
	for(var/k in all_clients)
		var/client/C = all_clients[k]
		C.to_chat(text_to_say,text_type)

proc/talk(var/atom/speaker, var/atom/source, var/text_to_say, var/text_type, var/frequency, var/language = LANGUAGE_BASIC)

	if(!text_to_say)
		return FALSE

	var/language/LA = SSlanguage.all_languages[language]

	var/text_to_say_language = LA ? LA.process_text(speaker,text_to_say) : "Blah blah blah."

	var/turf/source_turf = get_turf(source)

	switch(text_type)
		if(TEXT_RADIO) //People talking into radios.
			for(var/obj/item/device/radio/R in all_radios)
				CHECK_TICK
				if(get_turf(R) != source_turf)
					continue
				if(frequency == -1)
					frequency = R.frequency
				var/formatted_speech = format_speech(speaker,source,text_to_say,text_type,frequency,language)
				var/formatted_speech_language = format_speech(speaker,source,text_to_say_language,text_type,frequency,language)
				R.send_data(list("speaker" = speaker, "source" = source, "message" = formatted_speech, "language" = language, "message_language" = formatted_speech_language, "frequency" = frequency))
				//speaker.visible_message("\The [speaker.name] talks into \the [R.name].","You talk into \the [R.name].")
				break
			if(speaker.is_player_controlled()) LOG_CHAT("RADIO: [speaker.get_debug_name()]([frequency]): [text_to_say]")

		if(TEXT_RAW) //People talking out of radios, pretty much.
			for(var/mob/M in all_mobs_with_clients)
				CHECK_TICK
				if(within_range(M,source,TALK_RANGE))
					M.to_chat(text_to_say,CHAT_TYPE_RADIO)

		if(TEXT_WHISPER)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				var/formatted_speech = format_speech(speaker,source,text_to_say,text_type,frequency,language)
				var/formatted_speech_language = format_speech(speaker,source,text_to_say_language,text_type,frequency,language)
				for(var/mob/M in all_mobs_with_clients)
					CHECK_TICK
					if(within_range(M,source,WHISPER_RANGE))
						M.to_chat_language(formatted_speech,CHAT_TYPE_SAY,language,formatted_speech_language)

				for(var/obj/item/device/radio/R in all_radios)
					CHECK_TICK
					if(!R.broadcasting || get_dist(source_turf,R) > RADIO_WHISPER_RANGE)
						continue
					var/desired_frequency = frequency
					if(!desired_frequency)
						desired_frequency = R.frequency
					formatted_speech = format_speech(speaker,source,text_to_say,TEXT_RADIO,desired_frequency,language)
					formatted_speech_language = format_speech(speaker,source,text_to_say_language,TEXT_RADIO,desired_frequency,language)
					R.send_data(list("speaker" = speaker, "source" = source, "message" = text_to_say, "language" = language, "message_language" = formatted_speech_language, "frequency" = desired_frequency))
				if(speaker.is_player_controlled()) LOG_CHAT("WHISPER: [speaker.get_debug_name()]: [text_to_say]")

		if(TEXT_TALK)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				var/formatted_speech = format_speech(speaker,source,text_to_say,text_type,frequency,language)
				var/formatted_speech_language = format_speech(speaker,source,text_to_say_language,text_type,frequency,language)
				for(var/mob/M in all_mobs_with_clients)
					CHECK_TICK
					if(within_range(M,source,TALK_RANGE))
						M.to_chat_language(formatted_speech,CHAT_TYPE_SAY,language,formatted_speech_language)

				for(var/obj/item/device/radio/R in all_radios)
					CHECK_TICK
					if(!R.broadcasting || get_dist(source_turf,R) > RADIO_TALK_RANGE)
						continue
					var/desired_frequency = frequency
					if(!desired_frequency)
						desired_frequency = R.frequency
					formatted_speech = format_speech(speaker,source,text_to_say,TEXT_RADIO,desired_frequency,language)
					formatted_speech_language = format_speech(speaker,source,text_to_say_language,TEXT_RADIO,desired_frequency,language)
					R.send_data(list("speaker" = speaker, "source" = source, "message" = formatted_speech, "language" = language, "message_language" = formatted_speech_language, "frequency" = desired_frequency))
			if(speaker.is_player_controlled()) LOG_CHAT("TALK: [speaker.get_debug_name()]: [text_to_say]")

		if(TEXT_YELL)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				var/formatted_speech = format_speech(speaker,source,text_to_say,text_type,frequency,language)
				var/formatted_speech_language = format_speech(speaker,source,text_to_say_language,text_type,frequency,language)
				for(var/mob/M in all_mobs_with_clients)
					CHECK_TICK
					if(within_range(M,source,YELL_RANGE))
						M.to_chat_language(formatted_speech,CHAT_TYPE_SAY,language,formatted_speech_language)

				for(var/obj/item/device/radio/R in all_radios)
					CHECK_TICK
					if(!R.broadcasting || get_dist(source_turf,R) > RADIO_YELL_RANGE)
						continue
					var/desired_frequency = frequency
					if(!desired_frequency)
						desired_frequency = R.frequency
					formatted_speech = format_speech(speaker,source,text_to_say,TEXT_RADIO,desired_frequency,language)
					formatted_speech_language = format_speech(speaker,source,text_to_say_language,TEXT_RADIO,desired_frequency,language)
					R.send_data(list("speaker" = speaker, "source" = source, "message" = formatted_speech, "language" = language, "message_language" = formatted_speech_language, "frequency" = desired_frequency))
			if(speaker.is_player_controlled()) LOG_CHAT("YELL: [speaker.get_debug_name()]: [text_to_say]")

		if(TEXT_LOOC)
			var/formatted_speech = format_speech(speaker,source,text_to_say,text_type)
			for(var/mob/M in all_mobs_with_clients)
				CHECK_TICK
				if(within_range(M,source,YELL_RANGE))
					M.to_chat(formatted_speech,CHAT_TYPE_LOOC)
			if(speaker.is_player_controlled()) LOG_CHAT("LOOC: [speaker.get_debug_name()]: [text_to_say]")

		if(TEXT_OOC)
			var/formatted_speech = format_speech(speaker,source,text_to_say,text_type)
			for(var/k in all_clients)
				CHECK_TICK
				var/client/C = all_clients[k]
				if(!C || !C.mob)
					continue
				C.to_chat(formatted_speech,CHAT_TYPE_OOC)

			if(SSwikibot && ENABLE_WIKIBOT)
				SSwikibot.process_string(source,text_to_say)
			if(speaker.is_player_controlled()) LOG_CHAT("OOC: [speaker.get_debug_name()]: [text_to_say]")

		if(TEXT_GHOST)
			var/formatted_speech = format_speech(speaker,source,text_to_say,text_type)
			for(var/k in all_clients)
				var/client/C = all_clients[k]
				CHECK_TICK
				if(!C.mob || !is_observer(C.mob))
					continue
				C.to_chat(formatted_speech,CHAT_TYPE_SAY)
			if(speaker.is_player_controlled()) LOG_CHAT("GHOST: [speaker.get_debug_name()]: [text_to_say]")

	if(language == LANGUAGE_BASIC && (text_type == TEXT_TALK || text_type == TEXT_YELL))
		var/area/A = get_area(source)
		if(A && !(A.flags_area & FLAGS_AREA_SINGLEPLAYER))
			new/obj/effect/chat_text(source,text_to_say)


/atom/proc/visible_message(var/third_person_text,var/first_person_text,var/blind_text,var/view_range=VIEW_RANGE)

	var/turf/T = get_turf(src)

	if(!T || (T.x == 0 && T.y == 0 && T.z == 0)) //Void
		return

	if(!first_person_text)
		first_person_text = third_person_text

	if(!blind_text)
		blind_text = third_person_text

	for(var/mob/M in all_mobs_with_clients)

		CHECK_TICK

		if(!M.client) //Just in case.
			continue

		var/turf/mob_turf = get_turf(M)

		if(!within_range(mob_turf,T,view_range))
			continue

		var/distance = get_dist(mob_turf,T)

		if(M.see_invisible < src.invisibility)
			continue

		var/local_first_person_text
		var/local_third_person_text
		var/local_blind_text

		if(M == src)
			local_first_person_text = span("distance_medium",first_person_text)
			local_third_person_text = span("distance_medium",third_person_text)
			local_blind_text = span("distance_medium",blind_text)
		else if(distance <= view_range*0.75)
			local_first_person_text = span("distance_medium",first_person_text)
			local_third_person_text = span("distance_medium",third_person_text)
			local_blind_text = span("distance_medium",blind_text)
		else if(distance <= view_range)
			local_first_person_text = span("distance_small",first_person_text)
			local_third_person_text = span("distance_small",third_person_text)
			local_blind_text = span("distance_small",blind_text)
		else
			local_first_person_text = span("distance_tiny",first_person_text)
			local_third_person_text = span("distance_tiny",third_person_text)
			local_blind_text = span("distance_tiny",blind_text)

		if(src in view(M.client.eye,VIEW_RANGE))
			if(src == M)
				M.to_chat(local_first_person_text)
			else
				M.to_chat(local_third_person_text)
		else
			M.to_chat(local_blind_text)
