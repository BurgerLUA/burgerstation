/mob/living/advanced/human/ai
	name = "greytide"
	enable_AI = TRUE
	icon = ""

/mob/living/advanced/human/ai/on_life_AI()

	if(!initialized)
		Initialize()
		return TRUE //Wait until next tick.

	if(time_prob(50))
		move_dir = pick(NORTH,EAST,SOUTH,WEST)
		handle_movement()
	else
		move_dir = 0
		handle_movement(TRUE)

	/*
	if(time_prob(5))
		var/list/ai_racism = list(
			"all access pls",
			"AI ROUGE",
			"ADMINS HELP IM BEING ROBUSTED",
			"what the fuck this isn't goon",
			"remove catgirls",
			"remove cargirls",
			"AI STATE LAWS NOW.",
			"LING IN MAINT",
			"HELP MAINT",
			"i'm going to post this on reddit",
			"engineering cna i have insulates?",
			"chef give me the whetstone pls i'll give it back",
			"THE MINE JUST TALKED",
			"HOS ROGUE CALL SHUTTLE",
			"unga bunga me want attachies",
			"ban goofball right fucking now, i'm sick of his fucking crusade against catgirls. let me fucking play my characters in peace. if players don't like catgirls, then they can go fuck off back to goon and never fucking return.",
			"SEC TO HOPLINE, THE CLOWN STOLE MY ID.",
			"NUKEOPS NEAR LIBRARY",
			"BOTANIST IS A CULT",
			"*scream",
			"todd howard you did it again",
			"move retard",
			"one day while andy was masturbating, woody got wood.",
			"i'm sick and fucking tired of all these new players ruining my HRP",
			"i don't care",
			"me too thanks",
			"i see purple and black everywhere what do",
			"admin to me",
			"LYNCH CLOWN",
			"BUILD. A. WALL.",
			"ha ha liggers",
			"how do i cure meth",
			"how do i fart",
			"burgerstation, more like ORGANDAMAGE hahahahahahah XD"
		)

		say(pick(ai_racism))
	*/


	 . = ..()

/mob/living/advanced/human/ai/speedy/
	name = "Speedy McSpeed"
	movement_delay = 1

/mob/living/advanced/human/ai/speedy/on_life_AI()

	if(!initialized)
		return TRUE

	if(prob(10))
		move_dir = pick(NORTH,EAST,SOUTH,WEST)

	handle_movement(TRUE)

	return TRUE

/mob/living/advanced/human/ai/logo
	name = "greytide"
	movement_delay = 32