//Ideal format:
//NameOfTopic_"Dialogue #1 #2 #3"_Link1Topic_Link2Topic_Link3Topic

/dialogue/

/dialogue/proc/get_dialogue_options(mob/living/advanced/player/P,list/known_options)
	return list()

/dialogue/proc/set_topic(mob/living/advanced/player/P,topic) //When you click on a dialogue option. topic var should be unsanitized

	if(!topic)
		CRASH("No topic arg presented!")

	var/savedata/client/mob/mobdata = MOBDATA(P.ckey_last)
	var/menu/M = get_menu(/menu/dialogue/)

	var/list/known_options = mobdata.loaded_data["known_topics"] //Optional

	var/list/dialogue_options = get_dialogue_options(P,known_options)
	if(!length(dialogue_options))
		log_error("Dialogue Error: [P.get_debug_name()] found no dialogue options for dialogue [type]:[topic]!")
		return FALSE

	var/list/chosen_dialogue = dialogue_options[topic]
	if(!length(chosen_dialogue))
		log_error("Dialogue Error: [P.get_debug_name()] cannot access [type]:[topic]!")
		return FALSE

	var/dialogue = chosen_dialogue[1]

	var/final_topic = "[topic]_[dialogue]"

	for(var/i=2,i<=length(chosen_dialogue),i++)

		final_topic += "_[chosen_dialogue[i]]"

		var/first_letter = copytext(chosen_dialogue[i],1,2)

		if(first_letter != "*")
			mobdata.loaded_data["known_topics"] |= chosen_dialogue[i]

	if(topic == "hello")
		for(var/k in dialogue_options & known_options)
			final_topic += "_[k]"

	M.run_function(P,"set_topic","\"[url_encode(final_topic)]\"")

	return TRUE
