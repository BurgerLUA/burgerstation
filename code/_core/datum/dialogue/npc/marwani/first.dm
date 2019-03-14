/dialogue/npc/marwani/tutorial
	id = "marwani_tutorial_dialogue"

/dialogue/npc/marwani/tutorial/get_dialogue_options(var/mob/living/advanced/player/P)

	var/list/dialogue_options = list()
	dialogue_options["hello"] = list(
		"Oh you're finally awake. How do you feel? You've been #1 now. I took it upon myself to bring you to an available bed and some new clothes.",
		"out for a couple a days"
	)

	dialogue_options["out for a couple a days"] = list(
		"Oh! Where are my manners? I'm being rude. My name is #2. I am the caretarker of this area in #1. ",
		"the realm",
		"Ilaeza Marwani"
	)

	dialogue_options["the realm"] = list(
		"Oh, shoot. I should not have said that. Usually someone else handles this sort of thing but they're uh... busy but...\n\
		...unfortunately you died, and with your death, you are now #1.",
		"trapped in Nar-sie's realm"
	)

	dialogue_options["trapped in Nar-sie's realm"] = list(
		"Everyone here is a prisoner of #1, including me. This is his realm where he stores souls for goodness knows what. Probably something to do with torturing us given our #2 and all. You should speak to #3 about it, he tends to introduce the new ones to our village... but apparantly he's been busy of late so I took up that duty.",
		"Nar-sie",
		"immortality",
		"the mayor"
	)

	dialogue_options["Nar-sie"] = list(
		"Nar'sie, Narsie, Nar-sie, the Dark Lord. He's the evil that owns this realm that he torments us in. Allegedly. It's actually quite nice here, well... at least inside #1.",
		"the village"
	)

	dialogue_options["immortality"] = list(
		"Oh, yes. You're full on immortal now. Absolutely everyone. Eating is optional. Sleeping is optional. Fun is optional. When you die, you'll be resurrected to the last #1 you used, or in the case if you're a new arrival, the one in #2.",
		"wishgranter",
		"the village"
	)
	dialogue_options["the mayor"] = list(
		"He's the uh... self proclaimed 'leader' of #1. He's been here longer than any of us and knows quite a bit about this place and the #2. You can find him on the surface... somewhere. He moves around a lot. I think #3 might help you find him if you ask nicely.",
		"the village",
		"cultists",
		"the bartender"
	)
	dialogue_options["cultists"] = list(
		"Yes. Worshippers of #1. Twisted, evil, and stuck here to torment us like everyone else. You probably died by one, yes? Everyone here has had a run in with them in our #2 one way or another.",
		"Nar-sie",
		"past life"
	)
	dialogue_options["wishgranter"] = list(
		"Oh, I don't know much about those things. Speak to #1 about it if you want to know more. I have to tend to the others.",
		"the mayor"
	)
	dialogue_options["the village"] = list(
		"Yes, we're located in a village that this ship is currently docked with. Our current leader is #1; he runs the place. I think.",
		"the mayor",
	)

	dialogue_options["past life"] = list(
		"I rather not talk about that right now. I have others to tend to. Please, go find #1. I believe they can tell you more about being #1.",
		"trapped in Nar-sie's realm"
	)


	return dialogue_options

