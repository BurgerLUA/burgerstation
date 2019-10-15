/var/icon/chat_tags = new('icons/hud/chattags.dmi')
/var/icon/chat_icons = new('icons/hud/chat_icon.dmi')


proc/format_speech(var/atom/speaker,var/atom/source,var/text,var/talk_type)

	//text = periodize(capitalize(sanitize(text)))

	var/html = "ERROR"
	switch(talk_type)
		if(TEXT_WHISPER)
			html = "[format_speaker(speaker,source)] whispers, &#34;[span("whisper",text)]&#34;"
		if(TEXT_TALK)
			html = "[format_speaker(speaker,source)] says, &#34;[span("say",text)]&#34;"
		if(TEXT_YELL)
			html = "[format_speaker(speaker,source)] yells, &#34;[span("yell",text)]&#34;"
		if(TEXT_LOOC)
			html = "[format_speaker(speaker,source,"LOOC")]: [span("looc",text)]"
		if(TEXT_OOC)
			html = "[format_speaker(speaker,source,"OOC")]: [span("ooc",text)]"
		if(TEXT_GHOST)
			html = "[format_speaker(speaker,source,"DEAD")] moans, &#34;[span("ghost",text)]&#34;"
		if(TEXT_BOT)
			html = "[format_speaker(speaker,source,"BOT")]: [span("bot",text)]"
		if(TEXT_RADIO)
			html = span("radio","[format_speaker(speaker,source)] broadcasts, &#34;[span("say",text)]&#34;")


	return html

proc/format_speaker(var/atom/speaker,var/atom/source,var/tag)

	var/append = ""

	if(is_radio(source))
		var/obj/item/radio/R = source
		append += "<img src='\ref[source.icon]' iconstate='[source.icon_state]' width=10px, height=10px></img>([R.frequency])"

	else if(!istext(source))
		append += "<a class='name' href='?chat_examine=\ref[speaker]'><img src='\ref[chat_icons.icon]' iconstate='info'></img></a>"

	if(tag)
		append += "<img src='\ref[chat_tags.icon]' iconstate='[tag]' class='chat_tag' alt='[tag]'></img>"

	return span(tag,trim("[append] [speaker]"))
