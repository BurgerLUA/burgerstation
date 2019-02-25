/client/verb/ooc(var/text_to_say as text)
	display_message(src,text_to_say,TEXT_OOC)

proc/broadcast(var/text_to_say as text)
	for(var/mob/object in world)
		object.to_chat(text_to_say)

/proc/warning(var/text)
	world.log << "## WARNING: [text]"

proc/display_message(var/mob/source as mob, var/text_to_say as text, var/text_type as num)
	if(!text_to_say)
		return FALSE

	text_to_say = sanitize(text_to_say)

	switch(text_type)
		if(TEXT_WHISPER)
			if(istype(source,/client/))
				source.to_chat("You cannot talk like this!")
				return
			else
				for(var/mob/object in range(source,2))
					object.to_chat(format_speech(source,text_to_say,text_type))
		if(TEXT_TALK)
			if(istype(source,/client/))
				source.to_chat("You cannot talk like this!")
				return
			else
				for(var/mob/object in range(source,VIEW_RANGE))
					object.to_chat(format_speech(source,text_to_say,text_type))
		if(TEXT_YELL)
			if(istype(source,/client/))
				source.to_chat("You cannot talk like this!")
				return
			else
				for(var/mob/object in range(source,VIEW_RANGE*3))
					object.to_chat(format_speech(source,text_to_say,text_type))
		if(TEXT_LOOC)
			for(var/mob/M in range(source,VIEW_RANGE))
				M.to_chat(format_speech(source,text_to_say,text_type))

		if(TEXT_OOC)
			for(var/mob/M in world)
				M.to_chat(format_speech(source,text_to_say,text_type))

/atom/proc/visible_message(var/third_person_text,var/first_person_text,var/blind_text,var/view_range=VIEW_RANGE)

	if(src.x == 0 && src.y == 0 && src.z == 0)
		return

	for(var/mob/M in all_mobs_with_clients)

		if(get_dist(M,src) > view_range)
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

		if(src in view(M))
			if(src == M)
				M.to_chat(local_first_person_text)
			else
				M.to_chat(local_third_person_text)
		else
			M.to_chat(local_blind_text)





