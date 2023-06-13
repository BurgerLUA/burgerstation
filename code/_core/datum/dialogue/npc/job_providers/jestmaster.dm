/dialogue/npc/jestmaster

/dialogue/npc/jestmaster/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Are you seeking #1 guidance, looking to join us as a #2, or just staring?",
		"Her",
		"clown"
	)

	.["Her"] = list(
		"Our patron goddess. #1 true form lays unknown to all, but Her effects are known if you look. Do you seek Her #2?",
		"Her",
		"wisdom"
	)

	.["wisdom"] = list(
		"A true #1 does not seek Fun out, rather becoming the Fun themselves.",
		"clown"
	)

	if(P.job == /job/clown)
		.["clown"] = list(
			"A #1 may forget, but they will eventually remember.",
			"clown"
		)

	else
		.["clown"] = list(
			"Anyone can be a #1. All is forgiven under #2 eyes, but you must abandon your past self. I must warn you, however. If you become one of us without being strong enough, you might find you're too weak to do anything.NEWLINE#3NEWLINE#4",
			"clown",
			"Her",
			"*Yes, become a clown.",
			"*No, do not become a clown."
		)

	.["*Yes, become a clown."] = list(
		"By the powers vested in me, you are now a #1 in #2 circus.",
		"clown",
		"Her"
	)

	.["*No, do not become a clown."] = list(
		"#1 generosity endures, if you change your mind.",
		"Her"
	)

/dialogue/npc/jestmaster/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	if(topic == "*Yes, become a clown." && P.job != /job/clown)
		P.set_job(/job/clown)