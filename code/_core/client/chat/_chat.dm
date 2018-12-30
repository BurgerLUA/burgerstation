/client/verb/ooc(var/text_to_say as text)
	display_message(src,text_to_say,TEXT_OOC)

proc/display_message(var/atom/source, var/text_to_say as text, var/text_type as num)
	switch(text_type)
		if(TEXT_WHISPER)
			if(istype(source,/client/))
				source.to_chat("You cannot talk like this!")
				return
			else
				for(var/atom/object in range(source,2))
					object.to_chat(format_speech(source,text_to_say,text_type))
		if(TEXT_TALK)
			if(istype(source,/client/))
				source.to_chat("You cannot talk like this!")
				return
			else
				for(var/atom/object in range(source,VIEW_RANGE))
					object.to_chat(format_speech(source,text_to_say,text_type))
		if(TEXT_YELL)
			if(istype(source,/client/))
				source.to_chat("You cannot talk like this!")
				return
			else
				for(var/atom/object in range(source,VIEW_RANGE*3))
					object.to_chat(format_speech(source,text_to_say,text_type))
		if(TEXT_LOOC)
			for(var/atom/object in range(source,VIEW_RANGE))
				object.to_chat(format_speech(source,text_to_say,text_type))

		if(TEXT_OOC)
			for(var/atom/object in world)
				object.to_chat(format_speech(source,text_to_say,text_type))

/atom/proc/visible_message(var/third_person_text,var/first_person_text,var/blind_text,var/view_range=VIEW_RANGE)
	for(var/atom/object in range(view_range))
		if(src in view(object))
			if(src == object)
				object.to_chat(first_person_text)
			else
				object.to_chat(third_person_text)
		else
			object.to_chat(blind_text)





