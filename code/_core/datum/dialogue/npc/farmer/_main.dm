/dialogue/npc/farmer/

/dialogue/npc/farmer/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	if(P.species == "human")
		switch(P.sex)
			if(MALE)
				dialogue_options["hello"] = list(
					"What 'chu want, boy?",
				)
			if(FEMALE)
				dialogue_options["hello"] = list(
					"What 'chu want, woman?",
				)

	else
		dialogue_options["hello"] = list(
			"I don't speak to aliens. Go bother that lizard alien woman."
		)

	dialogue_options["the mayor"] = list(
		"That filthy alien goes to hide in #1 to perform cult rituals, I tell you. You'd be smart to stay away from that fool.",
		"the caves"
	)

	dialogue_options["the caves"] = list(
		"There are plenty of caves around here. Go get lost in one, for all I care."
	)

	dialogue_options["wishgranter"] = list(
		"Some bright magic thing that makes you lizard lesbian or somethin'. Stay away from it if you know what's good for you.",
	)

	dialogue_options["Ilaeza Marwani"] = list(
		"Some filthy alien devil temptress or somethin', don't bother listening to it if you know what's good for you."
	)

	return dialogue_options
