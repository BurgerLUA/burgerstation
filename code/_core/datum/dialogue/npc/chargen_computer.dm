/dialogue/npc/chargen_computer/
	name = "IMB Piece of Shit"
	id = "chargen_computer"

/dialogue/npc/chargen_computer/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()


	if(known_options["email messages"])
		dialogue_options["hello"] = list(
			"You have successfully logged on as [P.real_name]. You have 9 new #1.",
			"email messages"
		)
	else
		dialogue_options["hello"] = list(
			"Welcome to IMB v0.6.3 home edition. Please enter your #1 to continue.",
			"*login name"
		)

	dialogue_options["*login name"] = list(
		"Processing..."
	)

	dialogue_options["*fail"] = list(
		"Login failed. Please enter your #1.",
		"*login name"
	)

	dialogue_options["*success"] = list(
		"You have successfully logged on as [P.real_name]. You have 9 new #1.",
		"email messages"
	)

	dialogue_options["email messages"] = list(
		"You have several emails from the following stations: #1, #2, #3, #4, #5, #6, #7, #8, #9",
		"*Aurora Station",
		"*Citadel Station",
		"*TG Station",
		"*Colonial Marines",
		"*Paradise Station",
		"*AuStation 13",
		"*Goonstation",
		"*Baystation",
		"*Burgerstation"
	)

	dialogue_options["*Aurora Station"] = list(
		"The email contains the following message:NEWLINE\
		Greetings [P.real_name],NEWLINE\
		We regret to inform you that your job application to Aurora Station was rejected.NEWLINE\
		Reason: Called a Tajara a nazi when expressing radical views. Next time, please be more considerate of Aurorastation Lore and understand that Tajara are communists.NEWLINE\
		End of message."
	)

	dialogue_options["*Citadel Station"] = list(
		"The email contains the following message:NEWLINE\
		Greetings [P.real_name],NEWLINE\
		We regret to inform you that your job application to Citadel Station was rejected.NEWLINE\
		Reason: Reported a crewmember trying to fuck Ian and describing their actions on comms. Kinkshaming is not tolerated here, especially when it's against members of staff.NEWLINE\
		End of message."
	)

	dialogue_options["*TG Station"] = list(
		"The email contains the following message:NEWLINE\
		Greetings [P.real_name],NEWLINE\
		We regret to inform you that your job application to TG Station was rejected.NEWLINE\
		Reason: Threw a toolbox at my catgirl gf. When questioned why they would assault my gf, they said that all catgirl players are all secretly males which is simply not true because I am not gay.NEWLINE\
		End of message."
	)

	dialogue_options["*Colonial Marines"] = list(
		"The email contains the following message:NEWLINE\
		Greetings [P.real_name],NEWLINE\
		We regret to inform you that your job application to Colonial Marines was rejected.NEWLINE\
		Reason: During a xenomorph invasion, they singlehandedly managed to defeat a xenomorph queen and their minions inside the main hive. This behavior is absolutely unacceptable as it does not follow proper RP escalation rules.NEWLINE\
		End of message."
	)

	dialogue_options["*Paradise Station"] = list(
		"The email contains the following message:NEWLINE\
		Greetings [P.real_name],NEWLINE\
		We regret to inform you that your job application to Paradise Station was rejected.NEWLINE\
		Reason: When asked about who they thought the most fuckable Star Fox character is, they instead said that they're not really into Star Fox that much. This is a very clear attack on furries and such attitude will not be tolerated here.NEWLINE\
		End of message."
	)

	dialogue_options["*AuStation 13"] = list(
		"The email contains the following message:NEWLINE\
		Greetings [P.real_name],NEWLINE\
		We regret to inform you that your job application to AuStation 13 was rejected.NEWLINE\
		Reason: cunt NEWLINE\
		End of message."
	)

	dialogue_options["*Goonstation"] = list(
		"The email contains the following message:NEWLINE\
		Greetings [P.real_name],NEWLINE\
		We regret to inform you that your job application to Goonstation was rejected.NEWLINE\
		Reason: None Provided. NEWLINE\
		Attached Files: #1. NEWLINE\
		End of message.",
		"fart.ogg"
	)

	dialogue_options["*Baystation"] = list(
		"The email contains the following message:NEWLINE\
		Greetings [P.real_name],NEWLINE\
		We regret to inform you that your job application to Baystation was rejected.NEWLINE\
		Reason: Wrote 2 paragraphs of flavor text. The minimum paragraph count for flavor text is 11 paragraphs. Please read the rules, next time. NEWLINE\
		End of message."
	)

	dialogue_options["*Burgerstation"] = list(
		"The email contains the following message:NEWLINE\
		Greetings [P.real_name],NEWLINE\
		We are happy to report that your job application to Burgerstation was accepted!NEWLINE\
		Please fill out the skills sheet forum attached to this email and send it to us as soon as you can.NEWLINE\
		Attached Files: #1 NEWLINE\
		End of message.",
		"skill-sheet-forum.pdf"
	)

	dialogue_options["skill-sheet-forum.pdf"] = list("Penis")

	return dialogue_options

/dialogue/npc/chargen_computer/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	switch(topic)
		if("*login name")
			var/desired_name = input("Please enter your legal name. Make sure your name is correct and isn't misspeeled.","Login Name") as text
			desired_name = police_input(desired_name, max_length = 32, capitalize = TRUE)
			var/confirm01 = input("Your name is \"[desired_name]\". Is this correct?","Login Name") in list("Wait, no.","Yes.")
			if(confirm01 == "Wait, no.")
				set_topic(P,"*fail")
				return .
			var/confirm02 = input("Are you sure your name is \"[desired_name]\"?","Login Name") in list("Hold up.","Yes, I said.")
			if(confirm02 == "Hold up.")
				set_topic(P,"*fail")
				return .
			var/confirm03 = input("You have entered \"[desired_name]\" as your login name. Are you sure this is correct?","Login Name") in list("Oh.","Yes, you IMB piece of shit.")

			if(confirm03 == "Oh.")
				set_topic(P,"*fail")
				return .

			P.real_name = desired_name
			P.name = "[P.real_name] ([P.ckey])"
			set_topic(P,"*success")


	return .