/proc/broadcast_to_clients(var/text_to_say as text, var/chat_type = CHAT_TYPE_OOC)
	for(var/k in all_clients)
		var/client/C = all_clients[k]
		C.to_chat(text_to_say,chat_type)

/proc/use_radio(var/atom/speaker, var/atom/source, var/text_to_say, var/language_text_to_say, var/text_type, var/frequency, var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE)

	var/list/radio_data = list(
		"speaker" = speaker,
		"source" = source,
		"text_to_say" = text_to_say,
		"language_text_to_say" = language_text_to_say,
		"text_type" = text_type,
		"frequency" = frequency,
		"language" = language,
		"talk_range" = talk_range
	)

	var/area/A = get_area(source)
	if(all_telecomms[A.area_identifier])
		for(var/k in all_telecomms[A.area_identifier])
			var/obj/structure/interactive/telecomms/TC = k
			TC.add_data(rustg_hash_string(RUSTG_HASH_SHA1,"\ref[speaker],\ref[source],[text_to_say]"),radio_data)

	play_sound('sound/items/radio.ogg',get_turf(source),range_max=VIEW_RANGE)

	return TRUE

/proc/use_ears(var/atom/speaker, var/atom/source, var/text_to_say, var/language_text_to_say, var/text_type, var/frequency, var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE)

	var/turf/T1 = get_turf(source)

	for(var/k in all_listeners)
		CHECK_TICK(75,FPS_SERVER)
		var/atom/A = k
		var/turf/T2 = get_turf(A)
		if(!within_range(T1,T2,talk_range))
			continue
		A.on_listen(speaker,source,text_to_say,language_text_to_say,text_type,frequency,language,talk_range)


	return TRUE


/proc/talk(var/atom/speaker, var/atom/source, var/text_to_say, var/text_type, var/frequency, var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE) //Range only applies to TALK and RADIO

	if(!text_to_say)
		return FALSE

	var/turf/source_turf = get_turf(source)

	var/language/LA = SSlanguage.all_languages[language]
	var/language_text_to_say = LA.process_text(speaker,text_to_say)

	switch(text_type)
		if(TEXT_RADIO) //Snowflake code.
			for(var/k in all_radios)
				CHECK_TICK(75,FPS_SERVER)
				var/obj/item/device/radio/R = k
				var/turf/T = get_turf(R)
				if(T == source_turf)
					R.on_listen(speaker,source,text_to_say,language_text_to_say,TEXT_TALK,R.frequency,language,talk_range)
					if(speaker.is_player_controlled()) log_chat("RADIO [frequency_to_name(R.frequency)]: [speaker.get_log_name()]: [text_to_say]")
					break
		if(TEXT_TALK)
			use_ears(speaker,source,text_to_say,language_text_to_say,text_type,frequency,language,talk_range)
			if(speaker.is_player_controlled()) log_chat("TALK: [speaker.get_log_name()]: [text_to_say]")
		if(TEXT_LOOC)
			var/formatted_speech = format_speech(speaker,source,text_to_say,text_type,talk_range)
			for(var/k in all_mobs_with_clients)
				var/mob/M  = k
				CHECK_TICK(75,FPS_SERVER)
				if(within_range(M,source,YELL_RANGE))
					M.to_chat(formatted_speech,CHAT_TYPE_LOOC)
			if(speaker.is_player_controlled()) log_chat("LOOC: [speaker.get_log_name()]: [text_to_say]")
		if(TEXT_OOC)
			var/formatted_speech = format_speech(speaker,source,text_to_say,text_type,talk_range)
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
			var/formatted_speech = format_speech(speaker,source,text_to_say,text_type,talk_range)
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

	if(text_type == TEXT_TALK)
		var/area/A = get_area(source)
		if(A && !(A.flags_area & FLAGS_AREA_SINGLEPLAYER))
			new/obj/effect/chat_text(source,language_text_to_say)

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
