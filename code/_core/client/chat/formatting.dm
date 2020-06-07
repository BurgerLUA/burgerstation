var/global/icon/chat_tags = new('icons/hud/chattags.dmi')
var/global/icon/chat_icons = new('icons/hud/chat_icon.dmi')
var/global/icon/chat_language = new('icons/hud/language.dmi')


proc/format_speech(var/speaker,var/datum/source,var/text,var/talk_type,var/frequency, var/language = LANGUAGE_BASIC)

	var/html = "ERROR"
	switch(talk_type)
		if(TEXT_WHISPER)
			html = "<i>[format_speaker(speaker,source, language = language)] whispers, &#34;[span("whisper",text)]&#34;</i>"
		if(TEXT_TALK)
			html = "[format_speaker(speaker,source, language = language)] says, &#34;[span("say",text)]&#34;"
		if(TEXT_YELL)
			html = "[format_speaker(speaker,source, language = language)] yells, <b>&#34;[span("yell",text)]&#34;</b>"
		if(TEXT_LOOC)
			html = "[format_speaker(speaker,source,"LOOC", language = language)]: [span("looc",text)]"
		if(TEXT_OOC)
			html = "[format_speaker(speaker,source,"OOC", language = language)]: [span("ooc",text)]"
		if(TEXT_GHOST)
			html = "[format_speaker(speaker,source,"DEAD", language = language)] moans &#34;[span("dead",text)]&#34;"
		if(TEXT_BOT)
			html = "[format_speaker(speaker,source,"BOT", language = language)]: [span("bot",text)]"
		if(TEXT_RADIO)
			ASSERT(frequency)
			var/radio_class = "radio_[lowertext(frequency_to_name(frequency))]"
			html = span(radio_class,"[format_speaker(speaker,source,null,frequency,language)] says, &#34;[span("say",text)]&#34;")
		if(TEXT_PM)
			html = "[format_speaker(speaker,source,"PM_OTHER", language = language)]: [span("pm_other",text)]"
		if(TEXT_PM_ADMIN_IN)
			html = "[format_speaker(speaker,source,"PM_IN", language = language)]: [span("admin",text)]"
		if(TEXT_PM_ADMIN_OUT)
			html = "[format_speaker(speaker,source,"PM_OUT, language = language")]: [span("admin",text)]"
		if(TEXT_RAW)
			html = text

	return html

proc/format_speaker(var/speaker,var/source,var/tag,var/frequency=-1,var/language = LANGUAGE_BASIC)

	var/speaker_text = "\The [speaker]"
	if(is_datum(speaker))
		speaker_text = "<a class='name' href='?chat_examine=\ref[speaker]'>[speaker_text]</a>"

	var/source_text = ""
	var/tag_text = ""

	if(frequency > 0)
		var/freq_name = frequency_to_name(frequency)
		source_text += "([freq_name == "Unknown" ? "[frequency] kHz" : freq_name]) "
		tag += " radio"

	. = trim("[source_text][speaker_text]")

	if(language != LANGUAGE_BASIC)
		tag += " [language]"
		tag_text += ICON_TO_HTML(chat_language.icon,language,16,16)

	if(tag)
		tag = trim(tag)
		tag_text += ICON_TO_HTML(chat_tags.icon,tag,32,10)
		. = span(tag,"[tag_text] [.]")

	return .