/dialogue/npc/head_of_security/


/dialogue/npc/head_of_security/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Welcome to the armory. Anyone is welcome to #1 here, and there is a #2 just behind me to test things out. I am also authorized to offer the #3 of #4 as well, if you want it.",
		"purchase firearms",
		"firing range",
		"job",
		"security officer"
	)

	.["purchase firearms"] = list(
		"NanoTrasen realized that Cargo Technicians were either pretty lazy, or extremely prone to declaring independence, so they just fired all of them and replaced them with vendors or cyborgs. \
		If you want to #1, just use the #2 here to vend yourself something good. You can also buy armor and general equipment here, so be sure to check everything out.",
		"purchase firearms",
		"vending machines"
	)

	.["vending machines"] = list(
		"It's simple. Just click on the button of the thing you want to buy, and it will automatically buy it and charge your account for it. No paperwork or licence required. Don't forget to get ammo for it."
	)

	.["job"] = list(
		"NanoTrasen wants some sort of cohesion in this shitfuck of an operation, so they encourage people to take on a #1. I offer the #2 role. Other heads may offer other roles, if you're less interesting in killing things.",
		"job",
		"security officer"
	)

	if(P.job == /job/security)
		.["security officer"] = list(
			"I sometimes forget this too, but you're already a #1.",
			"security officer"
		)
	else
		.["security officer"] = list(
			"I can certify you as a #1, if you want. No minimum requirements. Pays well, and you earn your paycheck by killing anything and everything on the planet. You can earn promotions with this job, unlike assistant. This will replace your old job, if you had one. Want it?NEWLINE#2NEWLINE#3",
			"security officer",
			"*Yes, become a security officer.",
			"*No, do not become a security officer."
		)

	.["*Yes, become a security officer."] = list(
		"By the powers vested in me, you are now officially a #1. Congrats, now go kill things.",
		"security officer"
	)

	.["*No, do not become a security officer."] = list(
		"Suit yourself. The #1 still stands.",
		"job"
	)

/dialogue/npc/head_of_security/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	if(topic == "*Yes, become a security officer." && P.job != /job/security)
		P.set_job(/job/security)