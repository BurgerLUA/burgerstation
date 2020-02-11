/var/icon/chat_tags = new('icons/hud/chattags.dmi')
/var/icon/chat_icons = new('icons/hud/chat_icon.dmi')


proc/format_speech(var/atom/speaker,var/atom/source,var/text,var/talk_type)

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
			html = "[format_speaker(speaker,source)] says, &#34;[span("say",text)]&#34;"
		if(TEXT_PM)
			html = "[format_speaker(speaker,source,"PM_OTHER")]: [span("pm_other",text)]"
		if(TEXT_PM_ADMIN_IN)
			html = "[format_speaker(speaker,source,"PM_IN")]: [span("admin",text)]"
		if(TEXT_PM_ADMIN_OUT)
			html = "[format_speaker(speaker,source,"PM_OUT")]: [span("admin",text)]"

	return html


proc/frequency_to_text(var/frequency)

	var/channel_name = frequency
	var/channel_class = "radio"

	switch(frequency)
		if(RADIO_FREQ_COMMON)
			channel_name = "Common"
			channel_class = "radio common"
		if(RADIO_FREQ_SHIP)
			channel_name = "ShipComm"
			channel_class = "radio ship"
		if(RADIO_FREQ_ALPHA)
			channel_name = "Alpha"
			channel_class = "radio alpha"
		if(RADIO_FREQ_BRAVO)
			channel_name = "Bravo"
			channel_class = "radio bravo"
		if(RADIO_FREQ_CHARLIE)
			channel_name = "Charlie"
			channel_class = "radio charlie"
		if(RADIO_FREQ_DELTA)
			channel_name = "Delta"
			channel_class = "radio delta"

	return list(channel_name,channel_class)

proc/format_speaker(var/atom/speaker,var/atom/source,var/tag)

	var/append = ""

	if(is_radio(source))
		var/obj/item/radio/R = source
		var/list/frequency_data = frequency_to_text(R.frequency)
		append += "<span class='[frequency_data[2]]'>"
		append += "<img src='\ref[source.icon]' iconstate='[source.icon_state]' width=10px, height=10px></img>([frequency_data[1]])"

	else if(!istext(source))
		append += "<a class='name' href='?chat_examine=\ref[speaker]'><img src='\ref[chat_icons.icon]' iconstate='info'></img></a>"

	if(tag)
		append += "<img src='\ref[chat_tags.icon]' iconstate='[tag]' class='chat_tag' alt='[tag]'></img>"

	if(is_radio(source))
		append += "</span>"


	return span(tag,trim("[append] [speaker]"))