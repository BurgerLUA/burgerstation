/dialogue/npc/head_of_security/


/dialogue/npc/hop/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"What? Want a #1? We could use more #2s here.",
		"job",
		"security officer"
	)

	.["job"] = list(
		"NanoTrasen wants some sort of cohesion in this shitfuck of an operation, so they encourage people to take on #1s. I offer the #2 role.",
		"job",
		"security officer"
	)

	.["security officer"] = list(
		"I can certify you as a #1, if you want.",
		"security officer"
	)