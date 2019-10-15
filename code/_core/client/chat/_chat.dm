/client/verb/ooc(var/text_to_say as text)

	if(!text_to_say)
		text_to_say = input("What would you like to say?")

	if(last_ooc+10 >= curtime)
		src.to_chat(span("warning","You're using OOC too fast!"))
		return FALSE

	display_message(src,src,text_to_say,TEXT_OOC)
	last_ooc = curtime

/*
/proc/broadcast(var/text_to_say as text, var/text_type = TEXT_OOC)
	for(var/mob/object in world)
		object.to_chat(text_to_say)
*/

/proc/broadcast_to_clients(var/text_to_say as text, var/text_type = TEXT_OOC)
	for(var/client/C in all_clients)
		C.to_chat(text_to_say,TEXT_OOC)

/proc/broadcast_to_role(var/text_to_say as text, var/text_type = TEXT_OOC, var/desired_role = FLAG_PERMISSION_NONE)
	for(var/client/C in all_clients)
		var/savedata/client/roles/R = C.roles
		var/actual_role = R.loaded_data["role"]
		if(actual_role & desired_role)
			C.to_chat(text_to_say,TEXT_OOC)

proc/display_message(var/atom/speaker, var/atom/source, var/text_to_say as text, var/text_type as num)

	//world.log << "display_message([speaker],[source],[text_to_say],[text_type])"

	var/turf/source_turf = get_turf(source)

	if(!text_to_say)
		return FALSE

	switch(text_type)
		if(TEXT_RADIO)
			for(var/mob/M in range(source_turf,RADIO_RANGE))
				if(!M.client)
					continue
				M.to_chat(format_speech(speaker,source,text_to_say,text_type,),CHAT_TYPE_RADIO)
			//We don't send to other radios because that's a fucking terrible idea.
		if(TEXT_WHISPER)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				for(var/mob/M in range(source_turf,WHISPER_RANGE))
					if(!M.client)
						continue
					M.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_SAY)

				for(var/obj/item/radio/R in all_radios)
					if(!R.enabled || !R.broadcasting || get_dist(source_turf,R) > RADIO_WHISPER_RANGE)
						continue
					R.send_data(list("speaker" = speaker, "source" = source, "message" = text_to_say))

		if(TEXT_TALK)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				for(var/mob/M in range(source_turf,TALK_RANGE))
					if(!M.client)
						continue
					M.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_SAY)

				for(var/obj/item/radio/R in all_radios)
					if(!R.enabled || !R.broadcasting || get_dist(source_turf,R) > RADIO_TALK_RANGE)
						continue
					R.send_data(list("speaker" = speaker, "source" = source, "message" = text_to_say))

		if(TEXT_YELL)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				for(var/mob/M in range(source_turf,YELL_RANGE))
					if(!M.client)
						continue
					M.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_SAY)

				for(var/obj/item/radio/R in all_radios)
					if(!R.enabled || !R.broadcasting || get_dist(source_turf,R) > RADIO_YELL_RANGE)
						continue
					R.send_data(list("speaker" = speaker, "source" = source, "message" = text_to_say))

		if(TEXT_LOOC)
			for(var/mob/M in range(source_turf,YELL_RANGE))
				if(!M.client)
					continue
				M.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_LOOC)

		if(TEXT_OOC)
			for(var/mob/M in world)
				if(!M.client)
					continue
				M.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_OOC)

			if(SSWikibot)
				SSWikibot.process_string(source,text_to_say)

	if(text_type == TEXT_TALK || text_type == TEXT_YELL)
		if(is_advanced(source))
			new/obj/chat_text(source,text_to_say)


/atom/proc/visible_message(var/third_person_text,var/first_person_text,var/blind_text,var/view_range=VIEW_RANGE)

	if(src.x == 0 && src.y == 0 && src.z == 0)
		return

	for(var/mob/M in all_mobs_with_clients)

		if(!M.client) //Just in case.
			continue

		if(get_dist(M,src) > view_range)
			continue

		if(M.see_invisible < src.invisibility)
			continue

		var/local_first_person_text
		var/local_third_person_text
		var/local_blind_text

		var/distance = get_dist(M,src)
		if(distance <= 2)
			local_first_person_text = span("distance_large",first_person_text)
			local_third_person_text = span("distance_large",third_person_text)
			local_blind_text = span("distance_large",blind_text)
		else if(distance <= 4)
			local_first_person_text = span("distance_medium",first_person_text)
			local_third_person_text = span("distance_medium",third_person_text)
			local_blind_text = span("distance_medium",blind_text)
		else if(distance <= 6)
			local_first_person_text = span("distance_small",first_person_text)
			local_third_person_text = span("distance_small",third_person_text)
			local_blind_text = span("distance_small",blind_text)
		else
			local_first_person_text = span("distance_tiny",first_person_text)
			local_third_person_text = span("distance_tiny",third_person_text)
			local_blind_text = span("distance_tiny",blind_text)

		if(src in view(M.client.eye))
			if(src == M)
				M.to_chat(local_first_person_text)
			else
				M.to_chat(local_third_person_text)
		else
			M.to_chat(local_blind_text)





