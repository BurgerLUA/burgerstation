/dialogue/npc/shopkeeper/

/dialogue/npc/shopkeeper/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"sup"
	)

	dialogue_options["the mayor"] = list(
		"uhhhhhhhhhhhhhhhhhhhhhhh go check with #1 or something, idk",
		"Crundus Bundus"
	)

	dialogue_options["Shopkeeper Eric"] = list(
		"uhhhhhhhhhhhhhhhhhhhhhhh that's me"
	)

	dialogue_options["Crundus Bundus"] = list(
		"he's the old dude to the north on #1 thing",
		"the farm"
	)

	dialogue_options["the farm"] = list(
		"dude just go north or whatever, it's literally right there"
	)

	return dialogue_options