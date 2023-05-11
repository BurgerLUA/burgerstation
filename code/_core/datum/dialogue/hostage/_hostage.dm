/dialogue/npc/hostage/

/dialogue/npc/hostage/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/mob/living/L = P.dialogue_target

	. = list()

	if(L.following) //If we're following someone
		if(L.following == P) //If we're following the person we're talking to.
			.["hello"] = list(
				"I am currently following you.NEWLINE#1",
				"*Stop following me."
			)
			.["*Stop following me."] = list(
				"I will wait here."
			)
		else //If we're following someone else.
			.["hello"] = list(
				"I am currently following someone else.NEWLINE#1",
				"*Follow me."
			)
			.["*Follow me."] = list(
				"I am currently following the orders of [L.following.real_name], so I cannot follow you."
			)
	else //We're not following someone.
		.["hello"] = list(
			"I am currently following no one.NEWLINE#1",
			"*Follow me."
		)
		if(length(P.followers) < 2) //They have less than 2 followers
			.["*Follow me."] = list(
				"I will follow."
			)
		else
			.["*Follow me."] = list(
				"You already have someone with you."
			)

/dialogue/npc/hostage/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	var/mob/living/advanced/npc/hostage/L = P.dialogue_target

	if(!L.ai) return

	if(L.hostage)
		switch(topic)
			if("*Stop following me.")
				if(L in P.followers)
					L.ai.set_move_objective(null)
					L.following = null
					P.followers -= L
			if("*Follow me.")
				if(length(P.followers) < 2 && !L.following)
					P.followers += L
					L.ai.set_move_objective(P,2,astar=TRUE,follow=TRUE)
					L.following = P
