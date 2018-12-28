proc/format_speech(var/atom/source,var/text,var/talk_type)

	text = periodize(capitalize(sanitize(text)))

	var/html = "ERROR"
	switch(talk_type)
		if(TEXT_WHISPER)
			html = "[format_speaker(source)] whispers, [span("whisper",text)]"
		if(TEXT_TALK)
			html = "[format_speaker(source)] says, [span("say",text)]"
		if(TEXT_YELL)
			html = "[format_speaker(source)] yells, [span("yell",text)]"
		if(TEXT_LOOC)
			html = "[format_speaker(source,"LOOC")]: [span("looc",text)]"
		if(TEXT_OOC)
			html = "[format_speaker(source,"OOC")]: [span("ooc",text)]"
		if(TEXT_GHOST)
			html = "[format_speaker(source,"GHOSTCHAT")] moans, [span("ghost",text)]"

	return html

proc/format_speaker(var/atom/source,var/tag = "")
	return span(tag,trim("[tag] \icon[source] [source]"))
