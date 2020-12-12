/dialogue/npc/hostage/assistant

/dialogue/npc/hostage/assistant/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/mob/living/advanced/npc/unique/hostage/L = P.dialogue_target

	. = list()

	if(!L.hostage)
		.["hello"] = list(
			"i'm rescued bro, go do something else"
		)
	else
		if(L.handcuffed)
			.["hello"] = list(
				pick("get these fucking #1 off me dude","bruh remove these #1","fucking shitsec slapped #1 on me, delete it"),
				"*handcuffs"
			)
			.["*handcuffs"] = list(
				"bruh how do you not know how to remove them, just examine me and hit remove dude"
			)
			return .

		if(L.following) //If we're following someone
			if(L.following == P) //If we're following the person we're talking to.
				.["hello"] = list(
					pick("are we there yet","bruh hurry it up","stop trying to rp and just get me out of here dude"),
					"*stop following me"
				)
				.["*stop following me"] = list(
					pick("make up your mind, jfc","fine dude just hurry up","don't leave me here retard")
				)
			else //If we're following someone else.
				.["hello"] = list(
					pick("what","what do you want dude","what is it"),
					"*follow me"
				)
				.["*follow me"] = list(
					"[L.following.real_name] seems cooler than you so i'm following them instead, my man"
				)
		else //We're not following someone.
			.["hello"] = list(
				pick("bruh fucking get me out of there","i don't know this map, fucking help me get out"),
				"*follow me"
			)
			if(length(P.followers) < 2) //They have less than two followers
				.["*follow me"] = list(
					pick("fine","you better know what you're doing dude")
				)
			else
				.["*follow me"] = list(
					"bruh you already have too many people with you, it might be gay that way"
				)

	return .