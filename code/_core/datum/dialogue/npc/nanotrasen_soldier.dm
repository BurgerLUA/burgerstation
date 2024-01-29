/dialogue/npc/soldier/

/dialogue/npc/soldier/get_dialogue_options(mob/living/advanced/player/P,list/known_options)

	var/mob/living/L = P.dialogue_target

	. = list()

	if(L.following) //If we're following someone
		if(L.following == P) //If we're following the person we're talking to.
			.["hello"] = list(
				"Awaiting orders.NEWLINE#1",
				"*stop following me"
			)
			.["*stop following me"] = list(
				"I will wait here.NEWLINE#1",
				"*follow me"
			)
		else //If we're following someone else.
			.["hello"] = list(
				"Awaiting orders.NEWLINE#1",
				"*follow me"
			)
			.["*follow me"] = list(
				"I am currently following the orders of [L.following.real_name], so I cannot follow you."
			)
	else //We're not following someone.
		.["hello"] = list(
			"Awaiting orders.NEWLINE#1",
			"*follow me"
		)
		if(length(P.followers) < 3) //They have less than 3 followers
			.["*follow me"] = list(
				"I will follow.NEWLINE#1",
				"*stop following me"
			)
		else
			.["*follow me"] = list(
				"You already have too many people with you."
			)

/dialogue/npc/soldier/set_topic(mob/living/advanced/player/P,topic)

	. = ..()

	if(!is_living(P.dialogue_target)) return

	var/mob/living/L = P.dialogue_target

	if(!L.ai) return

	switch(topic)
		if("*stop following me")
			if(L in P.followers)
				L.ai.set_move_objective(null)
				L.following = null
				P.followers -= L
		if("*follow me")
			if(length(P.followers) < 2 && !L.following)
				P.followers |= L
				L.following = P
				L.ai.set_move_objective(P,2,astar=TRUE,follow=TRUE)


