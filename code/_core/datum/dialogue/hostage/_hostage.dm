/dialogue/hostage/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/mob/living/L = P.dialogue_target

	. = list()

	.["hello"] = list("Awaiting orders.")

	if(L.following)
		if(L.following == P)
			.["*stop following me"] = list(
				"I will wait here."
			)
		else
			.["hello"] = list(
				"I am currently following the orders of [L.following.real_name]."
			)

	else
		if(length(P.followers) <= 0)
			.["*follow me"] = list(
				"I will follow."
			)
		else
			.["*follow me"] = list(
				"You already have someone with you."
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
			if(L in P.followers)
				L.ai.set_move_objective(null)
				L.following = null
				P.followers -= L
		if("*follow me")
			if(length(P.followers) <= 0)
				P.followers += L
				L.ai.set_move_objective(P,TRUE)
				L.following = null
	return .