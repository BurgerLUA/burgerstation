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


