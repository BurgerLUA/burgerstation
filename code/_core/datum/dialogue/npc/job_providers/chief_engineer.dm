/dialogue/npc/chief_engineer/


/dialogue/npc/chief_engineer/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"This here is engineering. You can look, but touching the supermatter is strictly off limits. You can #1 here, or take a #2 as an #3 if you think you got what it takes.",
		"purchase materials",
		"job",
		"engineer"

	)

	.["purchase materials"] = list(
		"NanoTrasen here ships materials mined from mining stations and puts them in a fancy #1 for you to buy at a discount.",
		"vending machines"
	)

	.["purchase firearms"] = list(
		"Yeah, we have some very special firearms for sale in the #1, as well as some vendors that security already has. Don't tell security we have special equipment, or they might raid us again.",
		"vending machines"
	)

	.["vending machines"] = list(
		"Press a button on the thing and you'll get what you pay for. That's how you can #1 here. Don't tell security, but you can also #2 here too.",
		"purchase materials",
		"purchase firearms"
	)

	.["job"] = list(
		"I'm going to be honest. Being an #1 is real simple: Just exist and you'll get paid for it. You can even get a #2 for doing nothing, too..",
		"engineer",
		"promotion"
	)

	.["promotion"] = list(
		"Spend a week on the #1 as a #2, and you'll get access to a special #3. Comes with better pay.",
		"job",
		"engineer",
		"promotion"
	)


	if(P.job == /job/engineer)
		.["engineer"] = list(
			"I sometimes forget this too, but you're already an #1.",
			"engineer"
		)
	else
		.["engineer"] = list(
			"I can make you an #1, if you want. No minimum requirements. You earn your paycheck by doing literally nothing. You can earn promotions with this job, unlike assistant. This will replace your old job, if you had one. Want it?NEWLINE#2NEWLINE#3",
			"engineer",
			"*Yes, become an engineer.",
			"*No, do not become an engineer."
		)

	.["*Yes, become an engineer."] = list(
		"I now declare that you are officially an #1. Congrats, now go do nothing.",
		"engineer"
	)

	.["*No, do not become an engineer."] = list(
		"Your loss. The #1 offer still stands.",
		"job"
	)

/dialogue/npc/chief_engineer/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	if(topic == "*Yes, become an engineer." && P.job != /job/engineer)
		P.set_job(/job/engineer)