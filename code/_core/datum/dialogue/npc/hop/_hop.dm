/dialogue/npc/hop/
	name = "Head of Personel"
	id = "hop"

/dialogue/npc/hop/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Ah, hello. I'm [name]. It's a pleasure to meet you. You must be one of the new hires? By the looks of it you're [P.real_name], correct? You're here for a new #1?",
		"job"
	)

	dialogue_options["job"] = list(
		"Ah, well, I'd love for you to get started but unfortunately all your #1 and information was burned in a raging #2 just south of here. Most of what you sent to us, except for your name, kinda got burned.",
		"paperwork",
		"phoron fire"
	)

	dialogue_options["paperwork"] = list(
		"Oh, all the important things from birth certificate, medical records, dental records, employment history, education history... all burned in that #1! Looks like you'll have to #2 from memory. You do remember the exact date and times of all those events, right?",
		"phoron fire",
		"fill the records"
	)

	dialogue_options["phoron fire"] = list(
		"Science well... did something, then that happened. An assistant was carrying the paperwork to my desk and boom. They died, along with the paperwork. In normal cases we'd just fire you and send you back home if you have missing paperwork, but there is of course a #1 needing to be filled...",
		"vacant assistant slot"
	)

	dialogue_options["vacant assistant slot"] = list(
		"Great! The job starts at 2 credits an hour, you work 2 hours per day, with free healthcare. Your union-mandated 5 minute break started 5 minutes ago so this means that you should get started with your assigned #1!NEWLINENEWLINEWait, you mean you were just asking about the job? Well, I'm afraid that is the only job you can take right now!",
		"task"
	)


	if(!known_options["vacant assistant slot"])
		dialogue_options["fill the records"] = list(
			"Oh, you don't need your records, yet! There is a #1 that needs filling since the accident! Since you have a lack of records, that is the only job you can fill right now!",
			"vacant assistant slot"
		)
	//else if(known_options["vacant assistant slot"])


	dialogue_options["task"] = list(
		"Right. Last I heard, the #1 needs help with #2 or something, ask them about it. Alternatively, some of the #3 need help with treating injuries",
		"chef",
		"tenderizing meat"
	)

	return dialogue_options