//Ideal format:
//NameOfTopic_"Dialogue #1 #2 #3"_Link1Topic_Link2Topic_Link3Topic

/dialogue/
	var/name = "Dialogue"
	var/id = "Dialogue"
	//* means hidden

/dialogue/proc/get_dialogue_options(var/mob/living/advanced/player/P)
	var/list/dialogue_options = list()
	return dialogue_options

/dialogue/proc/set_topic(var/mob/living/advanced/player/P,var/topic)
	var/menu/M = get_menu("dialogue")
	var/list/dialogue_options = get_dialogue_options(P)

	var/list/chosen_dialogue = dialogue_options[topic]

	var/final_topic = "[topic]_[chosen_dialogue[1]]"

	for(var/i=2,i<=length(chosen_dialogue),i++)
		final_topic += "_[chosen_dialogue[i]]"

	final_topic = url_encode(final_topic)

	M.run_function(P,"convert_data","\"[final_topic]\"")
