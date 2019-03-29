/var/icon/chat_tags = new('icons/hud/chattags.dmi')


proc/format_speech(var/atom/source,var/text,var/talk_type)

	//text = periodize(capitalize(sanitize(text)))



	var/html = "ERROR"
	switch(talk_type)
		if(TEXT_WHISPER)
			html = "[format_speaker(source)] whispers, &#34;[span("whisper",text)]&#34;"
		if(TEXT_TALK)
			html = "[format_speaker(source)] says, &#34;[span("say",text)]&#34;"
		if(TEXT_YELL)
			html = "[format_speaker(source)] yells, &#34;[span("yell",text)]&#34;"
		if(TEXT_LOOC)
			html = "[format_speaker(source,"LOOC")]: [span("looc",text)]"
		if(TEXT_OOC)
			html = "[format_speaker(source,"OOC")]: [span("ooc",text)]"
		if(TEXT_GHOST)
			html = "[format_speaker(source,"DEAD")] moans, &#34;[span("ghost",text)]&#34;"

	return html

proc/format_speaker(var/atom/source,var/tag)

	var/append = ""

	if(tag)
		append = "<img src='\ref[chat_tags.icon]' iconstate='[tag]' class='chat_tag' alt='[tag]'></img>"

	return span(tag,trim("[append] [source]"))
