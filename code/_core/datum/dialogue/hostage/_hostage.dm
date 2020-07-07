/dialogue/npc/hostage/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Are you going to get me to safety?",
		"*wait here",
		"*follow me"
	)

	.["*wait here"] = list(
		"Waiting here."
	)

	.["*follow me"] = list(
		"Following."
	)

	return .


/dialogue/npc/hostage/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	if(!is_living(P.dialogue_target))
		return .

	var/mob/living/L = P.dialogue_target

	if(!L.ai)
		return .

	switch(topic)
		if("*wait here")
			L.ai.set_move_objective(null)
		if("*follow me")
			L.ai.set_move_objective(P,TRUE)

	return .