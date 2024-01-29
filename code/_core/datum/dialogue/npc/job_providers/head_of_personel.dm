/dialogue/npc/hop/


/dialogue/npc/hop/get_dialogue_options(mob/living/advanced/player/P,list/known_options)

	. = list()

	.["hello"] = list(
		"Hello, [P.real_name]. Come for a #1? I could officially certify you as an #2. It's considered dead-end, with no potential for #3, but it can help you get started for other jobs where you can actually get a #3. I also handle #4 if you feel that you've made enough credits in this sector.",
		"job",
		"assistant",
		"promotion",
		"retirement"
	)

	.["retirement"] = list(
		"Unfortunately due to strict labor laws in this sector that allow employees to quit their job for any time for any reason, we are legally required for you to offer the option to retire, ending your contract. \
		Is this something you're interested in?NEWLINENEWLINE#1NEWLINE#2NEWLINENEWLINE(Retirement allows you to <b>permanently</b> delete your character and transfer all their experience to the experience redemption system. Additionally, all items on your character at the time of retirement are sold.)",
		"*Yes, retire and spend out the rest of your days being miserable over the fact that you don't have a job.",
		"*No, do not retire and continue to be happy that NanoTrasen provides."
	)

	.["job"] = list(
		"While you are recieving some regular income working for NanoTrasen, you could be receiving more by taking on a job. Taking on a job boosts some of your attributes and skills \
		while you have the job. In this case, I offer the #1 job which boosts all skills a little bit, but has has no chance of a #2. Don't worry, you can change your job any time.",
		"assistant",
		"promotion"
	)

	.["promotion"] = list(
		"After 1 week of working any #1, you can get a promotion. This will increase your pay as well as the skill bonuses you recieve. As an #2, you cannot be promoted, however all other jobs have promotions..",
		"job",
		"assistant"
	)

	if(P.job == /job/assistant)
		.["assistant"] = list(
			"You are currently an assistant. If you wish to change your #1, speak to the other Heads of Staff around the station to get a new #1.",
			"job"
		)
	else
		.["assistant"] = list(
			"I can give you the assistant #1, which provides bonuses to all skills, but has no #2. This will replace your old job. Do you accept?NEWLINE#3NEWLINE#4",
			"job",
			"promotion",
			"*Yes, become an assistant.",
			"*No, do not become an assitant."
		)

	.["*Yes, become an assistant."] = list(
		"Wonderful. By the powers invested in me, I now promote you to #1. You now have some passive skill bonuses and slightly increased pay.",
		"assistant"
	)

	.["*No, do not become an assitant."] = list(
		"Ah, the job isn't really for everyone. Let me know if you change your mind."
	)

	.["*Yes, retire and spend out the rest of your days being miserable over the fact that you don't have a job."] = list(
		"Darn labor unions."
	)

	.["*No, do not retire and continue to be happy that NanoTrasen provides."] = list(
		"Excellent choice. I am legally obligated to tell you that the offer still stands."
	)


/dialogue/npc/hop/set_topic(mob/living/advanced/player/P,topic)

	if(topic == "*Yes, retire and spend out the rest of your days being miserable over the fact that you don't have a job.")
		var/menu/M = get_menu(/menu/dialogue/)
		M.close(P)
		spawn
			var/desired_choice = input(P,"Are you sure you want to retire? This cannot be undone!","Retirement Plan","Cancel") as null|anything in list("Yes","No","Cancel")
			if(desired_choice == "Yes")
				var/savedata/client/mob/D = MOBDATA(P.ckey)
				if(D) D.delete_character(P)
		return TRUE

	. = ..()

	if(topic == "*Yes, become an assistant." && P.job != /job/assistant )
		P.set_job(/job/assistant)