/dialogue/npc/marwani/tutorial

/dialogue/npc/marwani/tutorial/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()
	dialogue_options["hello"] = list(
		"Oh you're finally awake. How do you feel? You've been #1 now. I took it upon myself to bring you to an available bed and some new clothes.",
		"out for a couple a days"
	)

	dialogue_options["out for a couple a days"] = list(
		"Oh! Where are my manners? I'm being rude. My name is #1. I am the caretarker of #2. ",
		"Ilaeza Marwani",
		"the realm"
	)

	dialogue_options["Ilaeza Marwani"] = list(
		"That is what I was called before I was in #1, that is what I am still called to this day. I prefer to keep things on a professional basis, so you can call me Marwani.",
		"the realm"
	)

	dialogue_options["the realm"] = list(
		"Oh, shoot. I should not have said that. Usually someone else handles this sort of thing but they're uh... busy but...NEWLINE\
		...unfortunately you died, and with your death, you are now #1 in #2 realm.NEWLINE\
		Sorry.",
		"trapped",
		"Nar-sie"
	)

	dialogue_options["trapped"] = list(
		"Everyone here is a prisoner of #1, including me. This is his realm where he stores souls for goodness knows what. Probably something to do with torturing us given our #2 and all. You should speak to #3 about it, he tends to introduce the new ones to our village... but apparantly he's been busy of late so I'm usually the one informing #4.",
		"Nar-sie",
		"immortality",
		"the mayor",
		"newcomers"
	)

	dialogue_options["newcomers"] = list(
		"There has been a large influx of newcomers lately, for some reason. They all come through the #1, usually unconscious. You were one of them.",
		"wishgranter"
	)

	dialogue_options["Nar-sie"] = list(
		"Nar'sie, Narsie, Nar-sie, the Dark Lord, the Dark Lordess. He, she, or it is the evil that owns this realm that he torments us in. Allegedly. It's actually quite nice here, well... at least inside #1.",
		"the village"
	)

	dialogue_options["immortality"] = list(
		"Oh, yes. You're full on immortal now. Absolutely everyone. Eating is optional. Sleeping is optional. Fun is optional. When you die, you'll be resurrected to the last #1 you used, or in the case if you're a new arrival, the one in #2.",
		"wishgranter",
		"the village"
	)
	dialogue_options["the mayor"] = list(
		"He's the uh... self-proclaimed 'leader' of #1. He's been here longer than any of us and knows quite a bit about this place and the #2. You can find him on the surface... somewhere. He moves around a lot. I think #3 might help you find him if you ask nicely.",
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
		"Oh, I don't know much about those things, but they give out a nice calming, relaxing #1. I believe #2 can tell you more about it if you ask nicely.",
		"magical aura",
		"the mayor"
	)
	dialogue_options["the village"] = list(
		"We're located in a village that this ship is currently docked with. Our current leader is #1; he runs the place. I think. Its #2 protects us from harm, mostly.",
		"the mayor",
		"magical aura"
	)
	dialogue_options["magical aura"] = list(
		"I'm afraid I don't know much about how it works; I just know that when near it, you feel total and utter pacification. I never questioned its inner workings, but if you want to know more I suggest speaking to #1 about it, or god forbid, #2.",
		"the mayor",
		"Bar-Shaleez"
	)

	dialogue_options["past life"] = list(
		"I rather not talk about that right now. I have others to tend to. Please, go find #1. I believe they can tell you more about #2's realm.",
		"the mayor",
		"Nar-sie"
	)

	dialogue_options["the bartender"] = list(
		"#1 is her name, you can find her at #2 in the southwest of #3. I believe she has seen #4 last.",
		"Miss Flanagan",
		"the bar",
		"the village",
		"the mayor"
	)

	dialogue_options["Miss Flanagan"] = list(
		"As I said, she's #1. I think she has seen #2 last in #3. If you want me to #4 about her, you'd be out of luck; she's the gossip queen and I rather not tread on her.",
		"the bartender",
		"the mayor",
		"the bar",
		"gossip"
	)

	dialogue_options["Bar-Shaleez"] = list(
		"I... er. Don't speak to her. I suggest ignoring what she has to say completely. Speak to me, or #1, if you have any questions that need answering. She is not that helpful, honestly.",
		"the mayor"
	)

	dialogue_options["the bar"] = list(
		"The bar is located southwest of the village. I believe I saw #1 in there today. #2 could probably tell you more about where he went, assuming he's not there already.",
		"the mayor",
		"Miss Flanagan"
	)

	dialogue_options["gossip"] = list(
		"I don't have time to gossip right now! I have people other than you to look after, and you need to go find #1. Perhaps another time we can chit-chat, yes?",
		"the mayor"
	)

	return dialogue_options

