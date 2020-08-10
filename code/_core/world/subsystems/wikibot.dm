#define WIKIBOT "text/wikibot.txt"

var/global/list/wikibot_list = list()

SUBSYSTEM_DEF(wikibot)
	name = "Wikibot Subsystem"
	desc = "A 'bot' that answers questions."
	priority = SS_ORDER_PRELOAD

	cpu_usage_max = 50
	tick_usage_max = 50

/subsystem/wikibot/Initialize()

	var/wikibot_file = rustg_file_read(WIKIBOT)

	if(wikibot_file)
		wikibot_list = json_decode(wikibot_file)
		log_subsystem(name,"Found [length(wikibot_list)] wikibot question/answer keys.")
	else
		log_subsystem(name,"Found no wikibot question/answer keys. Creating new one...")
		add_new_wikibot_key(list("what","is","wikibot"),"Wikibot is a bot-controlled OOC helper that helps answer commonly asked questions.")

	return ..()

/subsystem/wikibot/proc/add_new_wikibot_key(var/list/keywords,var/answer)
	wikibot_list += list(list("keywords" = keywords, "answer" = answer))
	rustg_file_write(json_encode(wikibot_list),WIKIBOT)
	return TRUE

/subsystem/wikibot/proc/process_string(var/asker,var/string_to_process)

	var/best_score = 0
	var/best_answer = null

	for(var/k in wikibot_list)
		var/list/wikibot_key = k
		var/question_keys = wikibot_key["keywords"]
		var/answer_key = wikibot_key["answer"]
		var/current_score = 0

		for(var/key in question_keys)
			CHECK_TICK(75,FPS_SERVER*3)
			if(!findtextEx(lowertext(string_to_process),key))
				continue
			current_score += 1

		if(current_score > best_score && current_score >= length(question_keys))
			best_answer = answer_key

	if(best_answer)
		broadcast_to_clients(format_speech("WikiBot","WikiBot","[asker], [best_answer]",TEXT_BOT))