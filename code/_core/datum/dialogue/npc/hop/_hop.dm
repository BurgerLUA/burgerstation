/dialogue/npc/hop/

/dialogue/npc/hop/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Ah, hello. I'm [P.dialogue_target.name]. It's a pleasure to meet you. You must be one of the new hires? By the looks of it you're [P.real_name], correct? You're here for a new #1?",
		"job"
	)

	dialogue_options["job"] = list(
		"Ah, well, I'd love for you to get started but unfortunately all your #1 and information was burned in a raging #2 just south of here.",
		"paperwork",
		"phoron fire"
	)

	dialogue_options["paperwork"] = list(
		"Oh, all the important things from birth certificate, medical records, dental records, employment history, education history...it was all burned in that #1! Looks like you'll have to #2 from memory. You do remember the exact date and times of all those events, right?",
		"phoron fire",
		"fill the records"
	)

	dialogue_options["phoron fire"] = list(
		"Science well... did something, then that happened. An assistant was carrying the paperwork to my desk and boom. They died, along with the paperwork. Under normal circumstances, we'd just fire you and send you back home if you have missing paperwork but as I said earlier, there is an #1 position needing to be filled.",
		"assistant"
	)

	dialogue_options["assistant"] = list(
		"The job starts at 2 credits an hour, you work 2 hours per day, with free healthcare. Speaking of, you should head to #1 for a  #2 while I start getting the #3 ready!",
		"medical",
		"medical checkup",
		"paperwork"
	)

	dialogue_options["medical checkup"] = list(
		"All newly hired NanoTrasen employees must report to #1 for a mandatory medical checkup. They won't stick any needles or anything inside you; it's just a very basic examination.",
		"medical"
	)

	dialogue_options["medical"] = list(
		"Medical is located in the east side of the station, directly behind me. Just go down to the hall south, then head east, then north. You should see medical to your east."
	)



	return dialogue_options