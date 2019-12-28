//Ideal format:
//NameOfTopic_"Dialogue #1 #2 #3"_Link1Topic_Link2Topic_Link3Topic

/dialogue/
	name = "Dialogue"
	var/id = null
	//* means hidden

/dialogue/proc/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)
	var/list/dialogue_options = list()
	return dialogue_options


/dialogue/proc/add_stored_topics_if_exist(var/mob/living/advanced/player/P)

	var/menu/M = get_menu("dialogue")
	var/list/known_options = P.mobdata.loaded_data["known_topics"]
	var/list/dialogue_options = get_dialogue_options(P,known_options)
	var final_topic_string = get_topic_string(P,"hello",dialogue_options)

	if(!final_topic_string)
		return FALSE

	for(var/topic in dialogue_options)
		if(topic in known_options)
			final_topic_string += "_[topic]"

	final_topic_string = url_encode(final_topic_string)

	M.run_function(P,"convert_data","\"[final_topic_string]\"")

	return TRUE

/dialogue/proc/get_topic_string(var/mob/living/advanced/player/P,var/topic,var/list/dialogue_options)

	var/list/chosen_dialogue = dialogue_options[topic]

	if(!length(chosen_dialogue))
		LOG_ERROR("ERROR: [P] cannot access chosen topic [topic]!")
		return FALSE

	var/dialogue = chosen_dialogue[1]

	var/final_topic = "[topic]_[dialogue]"

	for(var/i=2,i<=length(chosen_dialogue),i++)

		final_topic += "_[chosen_dialogue[i]]"

		var/first_letter = copytext(chosen_dialogue[i],1,2)

		if(!(chosen_dialogue[i] in P.mobdata.loaded_data["known_topics"]) && first_letter != "*")
			P.mobdata.loaded_data["known_topics"] += chosen_dialogue[i]

	return final_topic

/dialogue/proc/set_topic(var/mob/living/advanced/player/P,var/topic)
	var/menu/M = get_menu("dialogue")
	var/list/known_options = P.mobdata.loaded_data["known_topics"]
	var/final_topic_string = url_encode(get_topic_string(P,topic,get_dialogue_options(P,known_options)))
	M.run_function(P,"convert_data","\"[final_topic_string]\"")
