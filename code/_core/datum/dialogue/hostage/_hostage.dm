/dialogue/hostage/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["*wait here"] = list(
		"I will wait here."
	)

	.["*follow me"] = list(
		"I will follow."
	)

	return .


/dialogue/hostage/set_topic(var/mob/living/advanced/player/P,var/topic)

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