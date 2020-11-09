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
		if(TEXT_RADIO) //People talking into radios with the ; key.
			var/list/sent_frequencies = list()
			for(var/k in all_radios)
				var/obj/item/device/radio/R = k
				CHECK_TICK(75,FPS_SERVER)
				var/desired_frequency = frequency
				if(desired_frequency == -1 || !desired_frequency)
					desired_frequency = R.frequency
				if(length(sent_frequencies) && sent_frequencies["[desired_frequency]"])
					continue
				if(get_turf(R) != source_turf)
					continue
				var/formatted_speech = format_speech(speaker,source,text_to_say,text_type,desired_frequency,language)
				var/formatted_speech_language = format_speech(speaker,source,text_to_say_language,text_type,frequency,language)
				R.send_data(list("speaker" = speaker, "source" = source, "message" = formatted_speech, "language" = language, "message_language" = formatted_speech_language, "frequency" = desired_frequency))
				if(desired_frequency) sent_frequencies["[desired_frequency]"] = TRUE
				if(speaker.is_player_controlled()) log_chat("RADIO: [speaker.get_log_name()]([desired_frequency]): [text_to_say]")
				break

		if(TEXT_RAW) //People talking out of radios, pretty much. Note that this is formatted. (should probably remove this)
			for(var/k in all_mobs_with_clients)
				var/mob/M = k
				CHECK_TICK(75,FPS_SERVER)
				if(within_range(M,source,TALK_RANGE))
					M.to_chat(text_to_say,CHAT_TYPE_RADIO)

		if(TEXT_WHISPER)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				for(var/k in all_listeners)
					var/atom/A = k
					CHECK_TICK(75,FPS_SERVER)
					if(!within_range(A,source,WHISPER_RANGE))
						continue
					A.on_listen(speaker,source,text_to_say,text_type,frequency,language)
				var/list/sent_frequencies = list()
				for(var/k in all_radios)
					var/obj/item/device/radio/R = k
					CHECK_TICK(75,FPS_SERVER)
					if(!within_range(R,source,WHISPER_RANGE))
						continue
					R.on_listen(speaker,source,text_to_say,text_type,frequency,language)


		if(TEXT_TALK)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				var/formatted_speech = format_speech(speaker,source,text_to_say,text_type,frequency,language)
				var/formatted_speech_language = format_speech(speaker,source,text_to_say_language,text_type,frequency,language)
				for(var/k in all_listeners)
					var/atom/A = k
					CHECK_TICK(75,FPS_SERVER)
					if(!within_range(A,source,TALK_RANGE))
						continue
					A.on_listen(speaker,source,text_to_say,text_type,frequency,language)
					if(ismob(k))
						var/mob/M = k
						if(!M.client)
							continue
						M.to_chat_language(formatted_speech,CHAT_TYPE_SAY,language,formatted_speech_language)

				var/list/sent_frequencies = list()
				for(var/k in all_radios)
					var/obj/item/device/radio/R = k
					CHECK_TICK(75,FPS_SERVER)
					if(!R.broadcasting || get_dist(source_turf,R) > RADIO_TALK_RANGE)
						continue
					var/desired_frequency = frequency
					if(!desired_frequency)
						desired_frequency = R.frequency
					if(length(sent_frequencies) && sent_frequencies["[desired_frequency]"])
						continue
					formatted_speech = format_speech(speaker,source,text_to_say,TEXT_RADIO,desired_frequency,language)
					formatted_speech_language = format_speech(speaker,source,text_to_say_language,TEXT_RADIO,desired_frequency,language)
					R.send_data(list("speaker" = speaker, "source" = source, "message" = formatted_speech, "language" = language, "message_language" = formatted_speech_language, "frequency" = desired_frequency))
					if(desired_frequency) sent_frequencies["[desired_frequency]"] = TRUE
					if(speaker.is_player_controlled()) log_chat("RADIO: [speaker.get_log_name()]([desired_frequency]): [text_to_say]")
			if(speaker.is_player_controlled()) log_chat("TALK: [speaker.get_log_name()]: [text_to_say]")

		if(TEXT_YELL)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				var/formatted_speech = format_speech(speaker,source,text_to_say,text_type,frequency,language)
				var/formatted_speech_language = format_speech(speaker,source,text_to_say_language,text_type,frequency,language)
				for(var/k in all_listeners)
					var/atom/A = k
					CHECK_TICK(75,FPS_SERVER)
					if(!within_range(A,source,YELL_RANGE))
						continue
					A.on_listen(speaker,source,text_to_say,text_type,frequency,language)
					if(ismob(A))
						var/mob/M = k
						if(!M.client)
							continue
						M.to_chat_language(formatted_speech,CHAT_TYPE_SAY,language,formatted_speech_language)

				var/list/sent_frequencies = list()
				for(var/k in all_radios)
					var/obj/item/device/radio/R = k
					CHECK_TICK(75,FPS_SERVER)
					if(!R.broadcasting || get_dist(source_turf,R) > RADIO_YELL_RANGE)
						continue
					var/desired_frequency = frequency
					if(!desired_frequency)
						desired_frequency = R.frequency
					if(length(sent_frequencies) && sent_frequencies["[desired_frequency]"])
						continue
					formatted_speech = format_speech(speaker,source,text_to_say,TEXT_RADIO,desired_frequency,language)
					formatted_speech_language = format_speech(speaker,source,text_to_say_language,TEXT_RADIO,desired_frequency,language)
					R.send_data(list("speaker" = speaker, "source" = source, "message" = formatted_speech, "language" = language, "message_language" = formatted_speech_language, "frequency" = desired_frequency))
					if(desired_frequency) sent_frequencies["[desired_frequency]"] = TRUE
					if(speaker.is_player_controlled()) log_chat("RADIO: [speaker.get_log_name()]([desired_frequency]): [text_to_say]")
			if(speaker.is_player_controlled()) log_chat("YELL: [speaker.get_log_name()]: [text_to_say]")

		if(TEXT_LOOC)
			var/formatted_speech = format_speech(speaker,source,text_to_say,text_type)
			for(var/k in all_mobs_with_clients)
				var/mob/M  = k
				CHECK_TICK(75,FPS_SERVER)
				if(within_range(M,source,YELL_RANGE))
					M.to_chat(formatted_speech,CHAT_TYPE_LOOC)
			if(speaker.is_player_controlled()) log_chat("LOOC: [speaker.get_log_name()]: [text_to_say]")

		if(TEXT_OOC)
			var/formatted_speech = format_speech(speaker,source,text_to_say,text_type)
			for(var/k in all_clients)
				CHECK_TICK(75,FPS_SERVER)
				var/client/C = all_clients[k]
				if(!C || !C.mob)
					continue
				C.to_chat(formatted_speech,CHAT_TYPE_OOC)

			if(SSwikibot && ENABLE_WIKIBOT)
				SSwikibot.process_string(source,text_to_say)
			if(speaker.is_player_controlled()) log_chat("OOC: [speaker.get_log_name()]: [text_to_say]")

		if(TEXT_GHOST)
			var/formatted_speech = format_speech(speaker,source,text_to_say,text_type)
			for(var/k in all_clients)
				CHECK_TICK(75,FPS_SERVER)
				var/client/C = all_clients[k]
				if(!C.mob)
					continue
				if(is_living(C.mob))
					var/mob/living/L = C.mob
					if(!L.dead)
						continue
				else if(!is_observer(C.mob))
					continue
				C.to_chat(formatted_speech,CHAT_TYPE_SAY)
			if(speaker.is_player_controlled()) log_chat("GHOST: [speaker.get_log_name()]: [text_to_say]")

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

	for(var/k in all_mobs_with_clients)
		var/mob/M = k

		CHECK_TICK(50,FPS_SERVER)

		if(!M.client) //Just in case.
			continue

		var/turf/mob_turf = get_turf(M)

		if(mob_turf.z != T.z)
			continue

		if(!within_range(mob_turf,T,view_range))
			continue

		var/distance = get_dist(mob_turf,T)

		if(M.see_invisible < src.invisibility)
			continue

		var/local_first_person_text
		var/local_third_person_text
		//var/local_blind_text

		if(M == src)
			local_first_person_text = span("distance_medium",first_person_text)
			local_third_person_text = span("distance_medium",third_person_text)
			//local_blind_text = span("distance_medium",blind_text)
		else if(distance <= view_range*0.75)
			local_first_person_text = span("distance_medium",first_person_text)
			local_third_person_text = span("distance_medium",third_person_text)
			//local_blind_text = span("distance_medium",blind_text)
		else if(distance <= view_range)
			local_first_person_text = span("distance_small",first_person_text)
			local_third_person_text = span("distance_small",third_person_text)
			//local_blind_text = span("distance_small",blind_text)
		else
			local_first_person_text = span("distance_tiny",first_person_text)
			local_third_person_text = span("distance_tiny",third_person_text)
			//local_blind_text = span("distance_tiny",blind_text)

		if(src == M)
			M.to_chat(local_first_person_text)
		else
			M.to_chat(local_third_person_text)
