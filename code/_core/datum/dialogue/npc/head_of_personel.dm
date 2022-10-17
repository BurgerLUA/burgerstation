/dialogue/npc/hop/


/dialogue/npc/hop/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Hello, [P.real_name]. Come for a #1? I could officially certify you as an #2. It's considered dead-end but it can help you get started for other jobs where you can actually get a #3.",
		"job",
		"assistant",
		"promotion"
	)

	.["job"] = list(
		"While you are recieving some regular income working for NanoTrasen, you could be receiving more by taking on a job. Taking on a job boosts some of your attributes and skills \
		while you have the job. In this case, I offer the assistant job which boosts all skills a little bit, but has has no chance of a #1. Don't worry, you can change your job any time.",
		"promotion"
	)

	.["promotion"] = list(
		"After 1 week of working any #1, you can get a promotion. This will increase your pay as well as the skill bonuses you recieve. As an assistant, you cannot be promoted, unfortunately.",
		"job"
	)

	.["assistant"] = list(
		"I can give you the assistant #1, which provides bonuses to all skills, but has no #2. This will replace your old job. Do you accept?NEWLINE#3NEWLINE#4",
		"job",
		"promotion",
		"*Yes, become an assistant.",
		"*No, do not become an assitant."
	)

	.["*Yes, become an assistant."] = list(
		"Wonderful. By the powers invested in me, I now promote you to assistant. You now have some passive skill bonuses and slightly increased pay."
	)

	.["*No, do not become an assitant."] = list(
		"Ah, the job isn't really for everyone. Let me know if you change your mind."
	)


/dialogue/npc/hop/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	if(topic == "*Yes, become an assistant.")
		P.set_job(/job/assistant)