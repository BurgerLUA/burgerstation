/var/icon/chat_tags = new('icons/hud/chattags.dmi')
/var/icon/chat_icons = new('icons/hud/chat_icon.dmi')


proc/format_speech(var/datum/speaker,var/datum/source,var/text,var/talk_type,var/frequency=RADIO_FREQ_COMMON)

	var/html = "ERROR"
	switch(talk_type)
		if(TEXT_WHISPER)
			html = "<i>[format_speaker(speaker,source)] whispers, &#34;[span("whisper",text)]&#34;</i>"
		if(TEXT_TALK)
			html = "[format_speaker(speaker,source)] says, &#34;[span("say",text)]&#34;"
		if(TEXT_YELL)
			html = "[format_speaker(speaker,source)] yells, <b>&#34;[span("yell",text)]&#34;</b>"
		if(TEXT_LOOC)
			html = "[format_speaker(speaker,source,"LOOC")]: [span("looc",text)]"
		if(TEXT_OOC)
			html = "[format_speaker(speaker,source,"OOC")]: [span("ooc",text)]"
		if(TEXT_GHOST)
			html = "[format_speaker(speaker,source,"DEAD")] moans, &#34;[span("ghost",text)]&#34;"
		if(TEXT_BOT)
			html = "[format_speaker(speaker,source,"BOT")]: [span("bot",text)]"
		if(TEXT_RADIO)
			var/radio_class = "radio_[lowertext(frequency_to_name(frequency))]"
			html = span(radio_class,"[format_speaker(speaker,source,null,frequency)] says, &#34;[span("say",text)]&#34;")
		if(TEXT_PM)
			html = "[format_speaker(speaker,source,"PM_OTHER")]: [span("pm_other",text)]"
		if(TEXT_PM_ADMIN_IN)
			html = "[format_speaker(speaker,source,"PM_IN")]: [span("admin",text)]"
		if(TEXT_PM_ADMIN_OUT)
			html = "[format_speaker(speaker,source,"PM_OUT")]: [span("admin",text)]"

	return html

proc/format_speaker(var/datum/speaker,var/datum/source,var/tag,var/frequency=RADIO_FREQ_COMMON)


	var/speaker_text = "<a class='name' href='?chat_examine=\ref[speaker]'>\The [speaker]</a>"
	var/source_text = ""
	var/tag_text = ""

	if(is_atom(source))
		var/atom/A = source
		source_text += "<img src='\ref[A.icon]' iconstate='[A.icon_state]' width='10px' height='10px'/>"
		if(is_radio(source))
			source_text += "([frequency_to_name(frequency)])"
			tag += " radio"

	. = trim("[source_text][speaker_text]")

	if(tag)
		tag = trim(tag)
		tag_text += "<img src='\ref[chat_tags.icon]' iconstate='[tag]' class='chat_tag' alt='[tag]'/>"
		. = span(tag,"[tag_text] [.]")

	return .



/*
proc/format_speaker(var/datum/speaker,var/datum/source,var/tag,var/frequency=RADIO_FREQ_COMMON)

	. = ""

	if(is_radio(source))
		var/obj/item/radio/R = source
		. += "<img src='\ref[R.icon]' iconstate='[R.icon_state]' width=10px, height=10px></img>([frequency_to_name(frequency)])"
		tag += " radio"
	else
		. += "<a class='name' href='?chat_examine=\ref[speaker]'></a>"

	if(tag)
		tag = trim(tag)
		. += "<img src='\ref[chat_tags.icon]' iconstate='[tag]' class='chat_tag' alt='[tag]'></img>"

	return span(tag,trim("[.]\The [speaker]"))
*/