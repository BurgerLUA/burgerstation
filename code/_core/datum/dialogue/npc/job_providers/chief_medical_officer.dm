/dialogue/npc/chief_medical_officer


/dialogue/npc/chief_medical_officer/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Welcome to the Medical Department. Due to staffing shortages, we're considered 99 percent self serve, and we'll offer a #1 to anyone who is qualified to be a #2.",
		"job",
		"medical doctor"
	)

	.["job"] = list(
		"No one wants to be a #1 these days. It's all about killing or blowing shit up. Internal research suggests that being a #1 has too many requirements, such as a high school diploma, so we're doing without them entirely. Become one today!",
		"medical doctor"
	)

	if(P.job == /job/medical)
		.["medical doctor"] = list(
			"I sometimes forget this too, but you're already a #1.",
			"medical doctor"
		)
	else
		.["medical doctor"] = list(
			"The only requirement to becoming a #1 is your consent. Do you consent to becoming a #1? You basically gain income for treating people, so that's cool.NEWLINE#2NEWLINE#3",
			"medical doctor",
			"*Yes, become a medical doctor.",
			"*No, do not become a medical doctor."
		)

	.["*Yes, become a medical doctor."] = list(
		"By the powers vested in me, you are now officially a #1. Congrats, now go heal people.",
		"medical doctor"
	)

	.["*No, do not become a medical doctor."] = list(
		"Suit yourself. The #1 still stands.",
		"job"
	)

/dialogue/npc/chief_medical_officer/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	if(topic == "*Yes, become a medical doctor." && P.job != /job/medical)
		P.set_job(/job/medical)