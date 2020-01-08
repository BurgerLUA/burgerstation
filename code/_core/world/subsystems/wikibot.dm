var/global/list/wikibot_list = list()

var/subsystem/wikibot/SSWikibot

/subsystem/wikibot/
	name = "Wikibot Subsystem"
	desc = "A 'bot' that answers questions."
	priority = SS_ORDER_PRELOAD

/subsystem/wikibot/New()
	SSWikibot = src
	return ..()

/subsystem/wikibot/Initialize()

	var/wikibot_file = file2text(WIKIBOT)

	if(wikibot_file)
		wikibot_list = json_decode(wikibot_file)

		LOG_SERVER("Found [length(wikibot_list)] wikibot question/answer keys.")
	else
		LOG_SERVER("Found no wikibot question/answer keys. Creating new one...")
		add_new_wikibot_key(list("what","is","wikibot"),"Wikibot is a bot-controlled OOC helper that helps answer commonly asked questions.")

/subsystem/wikibot/proc/add_new_wikibot_key(var/list/keywords,var/answer)
	wikibot_list += list(list("keywords" = keywords, "answer" = answer))
	fdel(WIKIBOT)
	text2file(json_encode(wikibot_list),WIKIBOT)
	return TRUE

/subsystem/wikibot/proc/process_string(var/asker,var/string_to_process)

	spawn()
		var/best_score = 0
		var/best_answer = null

		for(var/list/wikibot_key in wikibot_list)
			var/question_keys = wikibot_key["keywords"]
			var/answer_key = wikibot_key["answer"]
			var/current_score = 0

			for(var/key in question_keys)
				if(!findtextEx(lowertext(string_to_process),key))
					continue
				current_score += 1

			if(current_score > best_score && current_score >= length(question_keys))
				best_answer = answer_key

			sleep(-1)

		if(best_answer)
			broadcast_to_clients(format_speech("WikiBot","WikiBot","[asker], [best_answer]",TEXT_BOT))