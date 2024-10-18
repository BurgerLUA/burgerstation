/dialogue/npc/marwani/

/dialogue/npc/marwani/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Hello, is there something you wish to discuss? If not, you should go see #1 if you haven't already.",
		"the mayor"
	)

	dialogue_options["the mayor"] = list(
		"Have you talked to him yet? He should be here somewhere... have you tried checking #1?",
		"the bar"
	)

	dialogue_options["the bar"] = list(
		"Just because we've been cursed with #1 doesn't mean we can't have fun. It's a great place to go an socialize... assuming if there is any alcohol... and assuming we have any #2 to trade.",
		"immortality",
		"bluespace crystals"
	)

	dialogue_options["bluespace crystals"] = list(
		"Bluespace crystals are the currency of this realm. You use them to trade for goods and services at the shops here."
	)

	return dialogue_options