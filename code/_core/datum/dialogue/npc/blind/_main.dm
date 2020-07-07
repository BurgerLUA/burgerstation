/dialogue/npc/blind/

/dialogue/npc/blind/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Oh. Hello. I'm #1. Pleasure to meet you.",
		"Good John the Blind"
	)

	dialogue_options["Good John the Blind"] = list(
		"That's what they used to call me in my #1. Never bothered to change it. They say remembering who I was helps with the sanity. Don't know if that's true or not, but I'd like to believe.",
		"past life"
	)

	dialogue_options["the mayor"] = list(
		"They're a strange being that one is. You'd begin to think that they were the devil themselves with all the things they know. \
		If you're brave enough, you can try finding them near the #1 or the #2. They're usually there but I think they've been less social since #3.",
		"the farm",
		"the bank",
		"the discovery"
	)

	dialogue_options["past life"] = list(
		"Everyone has their own past life; before how they got here. Not many like to talk about it... but me? Hell, that might as well have been the Nar-sie's realm. \
		Was born blind. Couldn't see color nor notin'. Thankfully family was there to take care of me, but they weren't the nicest bunch. They thought I was the devil 'cause I couldn't \
		read the good book. Could hear the words that they were preaching in the church, though. Heard a lot of it cause it was the only thing to really do. \
		I thought that was good enough to get me into heaven. Guess I was wrong... or right depending on how you look at it. This place let me see like everyone else for the first time \
		so i consider that a blessin'. I can see the beauty of the grass, the sky, the water, the wood, the people, the animals. People are nicer here too, as long as you're inside \
		the walls. Can't say I miss my old life. I'm supposed to, according to #1, but I think he can be wrong sometimes.","the mayor"
	)

	dialogue_options["the discovery"] = list(
		"Oh shoot. I said too much now. Don't tell #1 I said that. He'd probably kill me. It's best that you don't mention it to him either.",
		"the mayor"
	)


	return dialogue_options

