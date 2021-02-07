/proc/announce(var/announcement_sender = "Unknown", var/announcement_title = "Untitled",var/annoumcent_text = "NULL",var/announcement_type = ANNOUNCEMENT_STATION,var/sound_to_play = null, var/language = LANGUAGE_BASIC, var/frequency = RADIO_FREQ_SHIP)

	var/language/LA = SSlanguage.all_languages[language]

	var/announcement_title_language = LA ? LA.process_text(announcement_sender,announcement_title) : "Blah blah blah."
	var/annoumcent_text_language = LA ? LA.process_text(announcement_sender,annoumcent_text) : "Blah blah blah."

	var/text_to_announce = "<div class='announcement [announcement_type]'><h2>[announcement_sender]</h2><h3>[announcement_title]</h3><p>[annoumcent_text]</p></div>"
	var/text_to_announce_language = "<div class='announcement [announcement_type]'><h2>[announcement_sender]</h2><h3>[announcement_title_language]</h3><p>[annoumcent_text_language]</p></div>"

	var/list/valid_mobs = list()

	if(announcement_type & ANNOUNCEMENT_STATION)
		for(var/k in all_mobs_with_clients)
			var/mob/M = k
			var/area/A = get_area(M)
			if(!is_living(M) || !(A.flags_area & FLAGS_AREA_NO_ROUND_INFORMATION))
				valid_mobs += M

	for(var/k in valid_mobs)
		var/mob/M = k
		var/knows_language = length(M.known_languages) && M.known_languages[language]
		if(knows_language)
			M.to_chat(text_to_announce,CHAT_TYPE_SAY)
		else
			M.to_chat(text_to_announce_language,CHAT_TYPE_SAY)

	if(sound_to_play)
		play_sound_global(sound_to_play,valid_mobs, sound_setting = SOUND_SETTING_UI)

