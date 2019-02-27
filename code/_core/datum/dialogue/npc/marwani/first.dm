/dialogue/npc/marwani/tutorial
	id = "marwani_tutorial_dialogue"

/dialogue/npc/marwani/tutorial/get_dialogue_options(var/mob/living/advanced/player/P)

	var/list/dialogue_options = list()
	dialogue_options["hello"] = list(
		"Oh you're finally #1. How do you feel?",
		"awake"
	)
	dialogue_options["awake"] = list(
		"Yes, you were #1 for quite some time now. I took it upon myself to bring you to an available bed and some new #2. I know it's not much but it's all we have.",
		"sleeping",
		"clothes"
	)
	dialogue_options["sleeping"] = list(
		"Yes, you've been out for a couple a days... Oh! I'm being rude. My name is #2. I am the caretarker of this area in the #1.",
		"the realm",
		"Ilaeza Marwani"
	)
	dialogue_options["clothes"] = list(
		"What? You want to know where your old clothes are? Er... ask me another time. They're currently being... washed. Yes. Washed."
	)
	dialogue_options["the realm"] = list(
		"Oh, shoot. I should not have said that. Usually someone else handles this sort of thing but... I suppose it wouldn't hurt to tell you now. You're er... you're trapped in #1's realm.",
		"Nar-sie"
	)
	dialogue_options["Nar-sie"] = list(
		"Nar'sie, Narsie, Nar-sie, the Dark Lord. Everyone here is a prisoner of Nar-sie. This is his realm where he stores souls for goodness knows what. To be honest, I don't think the dark lord knows #1.",
		"what happens here"
	)

	dialogue_options["what happens here"] = list(
		"Nothing really happens here, and that's what scares everyone! Like you'd think a dark lord's realm would be some place where people suffer for eternity but it's just like real life! Well, except for the fact that everyone has #1 and doesn't feel any pain.",
		"immortality"
	)
	dialogue_options["immortality"] = list(
		"Oh, yes. You're immortal now. Everyone and their cat is immortal in this realm, including insects and animals, including me. Eating is optional. Sleeping is optional. Fun is optional. When you die, you'll be resurrected to the last #1 you used, or in the case if you're a new arrival, the wishgranter in our #2.",
		"wishgranter",
		"village"
	)
	dialogue_options["the mayor"] = list(
		"He's the uh... self proclaimed 'leader' of our #1. He's been here longer than any of us and knows quite a bit about this place and the #2. You can find him on the surface... somewhere. He moves around a lot. The #3 might help you find him if you ask nicely.",
		"village",
		"cultists",
		"other villagers"
	)
	dialogue_options["other villagers"] = list(
		"Well there is me, #1, the caretaker. There is #2... the mayor. #3 watches over the #4 to the north of the #5.",
		"Ilaeza Marwani",
		"the mayor",
		"Bundy Bundus",
		"farm",
		"village",

	)
	dialogue_options["cultists"] = list(
		"You were fighting cultists before you arrived here? Well, that would explain much. You might want to talk to #1 about that.",
		"the mayor"
	)
	dialogue_options["wishgranter"] = list(
		"Oh, I don't know much about those things. Speak to #1 about it if you want to know more. I have to tend to the others.",
		"the mayor"
	)
	dialogue_options["village"] = list(
		"Yes, we're located in a village that this ship is currently docked with. Our current leader is #1; he runs the place. I think.",
		"the mayor",
	)

	return dialogue_options

