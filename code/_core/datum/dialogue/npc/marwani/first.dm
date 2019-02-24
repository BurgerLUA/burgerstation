/dialogue/npc/marwani/tutorial
	id = "marwani_tutorial_dialogue"

/dialogue/npc/marwani/tutorial/get_dialogue_options(var/mob/living/advanced/player/P)

	var/list/dialogue_options = list()
	dialogue_options["hello"] = list(
		"Oh you're finally #1. I was just about to tend to you. How do you feel?",
		"awake",
		"goodbye"
	)
	dialogue_options["awake"] = list(
		"You were #1. I took it upon myself to get you some better #2 and haul you to a free bed so you'd be comfortable. You're welcome.",
		"sleeping for quite some time",
		"clothes"
	)
	dialogue_options["sleeping for quite some time"] = list(
		"You've been out for a couple a days. I'd say you were in shock but things like shock doesn't really apply #1.",
		"where we are"
	)
	dialogue_options["clothes"] = list(
		"What? You want to know where your old clothes are? Er... ask me another time. They're currently being... washed. Yes. Washed."
	)
	dialogue_options["where we are"] = list(
		"I suppose it wouldn't hurt to tell you early. Usually someone else handles this sort of thing but... To put it blunty, you died and are now in #1's realm. Yay.",
		"Nar-sie"
	)
	dialogue_options["Nar-sie"] = list(
		"Nar'sie, Narsie, Nar-sie, the Dark Lord. Everyone here is a prisoner of Nar-sie. This is his realm where he stores souls for gods knows what. To be honest, I don't think the dark lord knows #1.",
		"what happens here"
	)

	dialogue_options["what happens here"] = list(
		"Nothing really happens here, and that's what scares everyone! Like you'd think hell would be some place where people #1 but it's just like real life! Well, except for the full-on #2.",
		"suffer for eternity",
		"immortality"
	)
	dialogue_options["suffer for eternity"] = list(
		"Oh, yeah you're supposed to be screaming in agony right now or something. I don't know. That's what the #1 say, at least.",
		"cultists"
	)
	dialogue_options["cultists"] = list(
		"You were fighting cultists before you arrived here? Well, that would explain much. You might want to talk to #1 about that, he has some sort of facination with those who've fought cultists in their previous life.",
		"the mayor"
	)
	dialogue_options["the mayor"] = list(
		"He's the uh... self proclaimed 'leader' of our #1. He's been here longer than any of us and knows quite a bit about this place. You can find him on the surface... somewhere. The other villagers will tell you more.",
		"village"
	)
	dialogue_options["immortality"] = list(
		"Oh, yes. You're immortal now. Everyone and their dog is immortal in this realm, including insects and animals. Eating is optional. Sleeping is optional. When you die, you'll be teleported to the last #1 you used, or in the case if you're a new arrival, the wishgranter in our #2.",
		"wishgranter",
		"village"
	)
	dialogue_options["wishgranter"] = list(
		"Oh, I don't know much about those things. Speak to #1 about it if you want to know more, if you're interested in a lecture.",
		"the mayor"
	)
	dialogue_options["village"] = list(
		"Yes, we're located in a village that this ship is currently docked with. Our current leader is #1; he runs the place, most of us don't do do much but assists #2 as much as we can.",
		"the mayor",
		"the others"
	)
	dialogue_options["the others"] = list(
		"You think you're the only one here? There were plenty of you before you. Most come at an hourly rate and it's very difficult to keep track of all of them. You should go speak to #1, as I have others to tend to.",
		"the mayor"
	)

	return dialogue_options

