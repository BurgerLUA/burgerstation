var/global/icon/chat_tags = new('icons/hud/chat_tags_old.dmi')
var/global/icon/chat_icons = new('icons/hud/chat_icon.dmi')
var/global/icon/chat_language = new('icons/hud/language.dmi')
var/global/icon/chat_toolbox = new('icons/hud/chat_toolbox_old.dmi')


/proc/format_language(var/speaker,var/text,var/language = LANGUAGE_BASIC) //Here lies a failed experiment
	var/language/LA = SSlanguage.all_languages[language]
	var/language_text = LA.process_text(speaker,text)
	return tooltip(text,language_text)

proc/format_speech(var/speaker,var/datum/source,var/text,var/talk_type,var/frequency,var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE,var/knows_language=TRUE)

	var/html = "ERROR"
	switch(talk_type)
		if(TEXT_TALK)
			if(talk_range >= YELL_RANGE)
				html = "[format_speaker(speaker,source, language = language)] yells, &#34;[span("yell",text)]&#34;"
			else if(talk_range <= WHISPER_RANGE)
				html = "<i>[format_speaker(speaker,source, language = language)] whispers, &#34;[span("whisper",text)]&#34;</i>"
			else
				html = "[format_speaker(speaker,source, language = language)] says, &#34;[span("say",text)]&#34;"
		if(TEXT_LOOC)
			html = "[format_speaker(speaker,source,"LOOC", language = language)]: [span("looc",text)]"
		if(TEXT_OOC)
			html = "[format_speaker(speaker,source,"OOC", language = language)]: [span("ooc",text)]"
		if(TEXT_GHOST)
			html = "[format_speaker(speaker,source,"DEAD", language = language)] moans, &#34;[span("dead",text)]&#34;"
		if(TEXT_BOT)
			html = "[format_speaker(speaker,source,"BOT", language = language)]: [span("bot",text)]"
		if(TEXT_RADIO)
			ASSERT(frequency)
			var/radio_class = "radio_[lowertext(frequency_to_name(frequency))]"
			if(talk_range >= YELL_RANGE)
				html = span(radio_class,"[format_speaker(speaker,source,null,frequency,language)] yells, &#34;[span("yell",text)]&#34;")
			else if(talk_range <= WHISPER_RANGE)
				html = span(radio_class,"[format_speaker(speaker,source,null,frequency,language)] whispers, &#34;[span("whisper",text)]&#34;")
			else
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

/proc/get_chat_icons(var/datum/speaker)

	. = ""

	if(is_client(speaker))
		var/client/C = speaker
		if(C.byond_member)
			. += ICON_TO_HTML(chat_icons.icon,"byond",20,20)
		if(C.permissions & FLAG_PERMISSION_BRONZE)
			. += ICON_TO_HTML(chat_toolbox.icon,"bronze",20,13)
		if(C.permissions & FLAG_PERMISSION_SILVER)
			. += ICON_TO_HTML(chat_toolbox.icon,"silver",20,13)
		if(C.permissions & FLAG_PERMISSION_GOLD)
			. += ICON_TO_HTML(chat_toolbox.icon,"gold",20,13)

	return .


/proc/get_ooc_color(var/datum/speaker) //WIP

	if(is_client(speaker))
		var/client/C = speaker
		if(C.permissions & FLAG_PERMISSION_HOST)
			return "#B71C00"
		else if(C.permissions & FLAG_PERMISSION_GOLD)
			return "#D9B131"
		else if(C.permissions & FLAG_PERMISSION_SILVER)
			return "#D4D4D4"
		else if(C.permissions & FLAG_PERMISSION_BRONZE)
			return "#D98531"

	return "#1339AC"


proc/format_speaker(var/speaker,var/source,var/tag,var/frequency=-1,var/language = LANGUAGE_BASIC)

	var/speaker_text = "<b>\The [speaker]</b>"
	var/source_text = ""
	var/tag_text = ""

	if(frequency > 0)
		var/freq_name = frequency_to_name(frequency)
		source_text += "\[[freq_name == "Unknown" ? "[frequency] kHz" : freq_name]\] "
		tag += " radio"

	. = trim("[source_text][speaker_text]")

	if(language != LANGUAGE_BASIC)
		tag += " [language]"
		tag_text += ICON_TO_HTML(chat_language.icon,language,16,16)

	if(tag)
		if(tag == "OOC")
			. = "[get_chat_icons(speaker)][.]"
		tag = trim(tag)
		tag_text += ICON_TO_HTML(chat_tags.icon,tag,32,10)
		. = span(tag,"[tag_text][.]")

	return .