/dialogue/tutorial/front_desk

/dialogue/tutorial/front_desk/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	var/area/A = get_area(P)

	var/is_on_burgerstation = istype(A,/area/burgerstation)

	if(is_on_burgerstation)
		dialogue_options["hello"] = list(
			"Greetings. I am Cyborg Assistant MK1. I am here to answer all your questions and concerns at your #1 at #2's #3! \
			If you have no questions, please #4.",
			"employment",
			"NanoTrasen",
			"Burgerstation",
			"get to work",
			"*Reward Redemption",
			"*Experience Redemption"
		)
	else
		dialogue_options["hello"] = list(
			"Greetings. I am Cyborg Assistant MK1. How can I assist you? Would you like to know about your #1? Perhaps about #2? Or even #3?",
			"employment",
			"NanoTrasen",
			"Burgerstation"
		)

	dialogue_options["employment"] = list(
		"You are currently hired as a #1 aboard #2. Your primary task is to shoot at the enemies of #3, which are currently the #4. You will be paid in #5 every 10 or so minutes, \
		with additional credit #6 based on your job performance.",
		"Corporate Mercenary",
		"Burgerstation",
		"NanoTrasen",
		"Syndicate",
		"credits",
		"bonuses"
	)

	dialogue_options["credits"] = list(
		"Credits is this sector's currency. Currently, all colonies, ships, and space stations use this to purchase goods and services. \
		When you applied to work for #1, a free bank acccount was automatically created in your Name and DNA hash, so you don't have to worry about any legal paperwork!",
		"NanoTrasen"
	)

	dialogue_options["bonuses"] = list(
		"Bonuses are earned if you aquire assets and perform research on the station. All assets found planetside should be sent back up and to the cargo system so they can \
		be re-sold, re-used, or re-purpose. Research can be done in the research wing of #1. Completion of these tasks will earn you additional #2.",
		"Burgerstation",
		"credits"
	)

	dialogue_options["NanoTrasen"] = list(
		"This is the company that you and I work for. We're the largest and bestest corporation in the world for a #1 to work for!",
		"Corporate Mercenary"
	)

	dialogue_options["Syndicate"] = list(
		"The Syndicate are an evil, ammoral, corrupt terrorist organization consisting of evil, ammoral, and corrupt terrorists. As per your #1, you are tasked with destroying \
		any and all Syndicate activity with lethal force.",
		"employment"
	)

	if(is_on_burgerstation)
		dialogue_options["Burgerstation"] = list(
			"Burgerstation is currently the station that you are on right now. You should #1 as soon as you can to assist your friends below!",
			"get to work"
		)
	else
		dialogue_options["Burgerstation"] = list(
			"Burgerstation is currently the station that this terminal will be heading to. You should board the #1 as soon as you can in order to #2!",
			"shuttle",
			"get to work"
		)

	if(is_on_burgerstation)
		dialogue_options["shuttle"] = list(
			"Are you refering to the #1 or the #2?",
			"Arrivals Shuttle",
			"Hanger Shuttles"
		)

		dialogue_options["Hanger Shuttles"] = list(
			"The Hanger Shuttles are located far west of the station. Be sure to gear up at the #1 before heading down #2!",
			"armory",
			"planetside"
		)

		dialogue_options["Arrivals Shuttle"] = list(
			"The Arrivals Shuttle is the shuttle that you came on to get on this station, from #1. While you can travel between #2 and #3, it is programmed to stay docked at #4 \
			unitl an organic lifeform boards.",
			"Central Command",
			"Burgerstation",
			"Central Command",
			"Burgerstation"
		)
		dialogue_options["Central Command"] = list(
			"Central Command is the link between civilization and #1. You are currently on #2, and should stay on it for the remainder of your employment.",
			"Burgerstation",
			"Burgerstation"
		)
		dialogue_options["*Reward Redemption"] = list(
			"Please whisper the secret phrase to redeem your reward."
		)
		dialogue_options["*Experience Redemption"] = list(
			"Select what experience you wish to redeem."
		)
	else
		dialogue_options["shuttle"] = list(
			"The shuttle takes new crewmembers to #1 from #2. You should be boarding it now so you can #3.",
			"Burgerstation",
			"Central Command",
			"get to work"
		)
		dialogue_options["Central Command"] = list(
			"Central Command is the link between civilization and #1. You are currently at Central Command right now!",
			"Burgerstation"
		)

	dialogue_options["Corporate Mercenary"] = list(
		"Your #1 can be summed up to: an organic with a gun that shoots other organics with guns in the name of #2. The legal term for that is armed contractor, but we think that doesn't sound as badass.",
		"employment",
		"NanoTrasen"
	)

	dialogue_options["get to work"] = list(
		"In order to be a smart #1, you must be a well-equipped #2. You should first explore a little, and then head to the #3. \
		From there, you can gear up and then head #4 to help secure the planet from #6 presence.",
		"Corporate Mercenary",
		"Corporate Mercenary",
		"armory",
		"planetside",
		"Syndicate"
	)

	dialogue_options["planetside"] = list(
		"Yes, there is a planet nearby full of enemy #1 presence. Your job as a #2 is to secure the planet from enemy #3 forces and claim it for #4!",
		"Syndicate",
		"Corporate Mercenary",
		"Syndicate",
		"NanoTrasen"
	)

	dialogue_options["armory"] = list(
		"The armory is located northeast inside #1.",
		"Burgerstation"
	)

	dialogue_options["*rewardfail"] = list(
		"It appears you did not enter a valid reward code.",
	)

	dialogue_options["*rewardsuccess"] = list(
		"Enjoy your reward!",
	)

	return dialogue_options



/dialogue/tutorial/front_desk/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	switch(topic)
		if("*Reward Redemption")
			var/desired_input = input("Please enter the reward code. Reward codes are case sensitive.","Reward Code") as text
			desired_input = sanitize(desired_input)
			if(desired_input && SSreward.check_code(P.client,desired_input))
				set_topic(P,"*rewardsuccess")
			else
				set_topic(P,"*rewardfail")
		if("*Experience Redemption")
			var/savedata/client/globals/G = GLOBALDATA(P.ckey)
			var/list/data_to_use = G.loaded_data["stored_experience"]

			if(length(data_to_use))
				var/list/choice_list = list()
				for(var/k in data_to_use)
					var/v = data_to_use[k]
					choice_list["[k]: [v]xp"] = k
				var/desired_experience = input("What experience would you like to redeem?","Experience Redemption") as null|anything in choice_list
				if(desired_experience)
					desired_experience = choice_list[desired_experience]
					var/desired_redeem_amount = input("How much [desired_experience]xp do you wish to redeem? (Max: [data_to_use[desired_experience]])","[desired_experience] experience redemption") as num
					if(desired_redeem_amount && desired_redeem_amount > 0)
						desired_redeem_amount = min(desired_redeem_amount,data_to_use[desired_experience])
						if(P.attributes[desired_experience])
							desired_redeem_amount = P.add_attribute_xp(desired_experience,desired_redeem_amount)
							G.loaded_data["stored_experience"][desired_experience] -= desired_redeem_amount
							P.to_chat(span("notice","You redeem [desired_redeem_amount] (attribute) [desired_experience] experience. You now have [G.loaded_data["stored_experience"][desired_experience]] experience stored."))
						else if(P.skills[desired_experience])
							desired_redeem_amount = P.add_skill_xp(desired_experience,desired_redeem_amount)
							G.loaded_data["stored_experience"][desired_experience] -= desired_redeem_amount
							P.to_chat(span("notice","You redeem [desired_redeem_amount] (skill) [desired_experience] experience. You now have [G.loaded_data["stored_experience"][desired_experience]] experience stored."))

						else
							P.to_chat(span("notice","Something went wrong. Report this bug to burger on discord with the error: 1.[desired_experience].[desired_redeem_amount]."))
					else
						P.to_chat(span("notice","You decide not to redeem anything."))
				else
					P.to_chat(span("notice","You decide not to redeem anything."))
				set_topic(P,"*rewardsuccess")
			else
				P.to_chat(span("notice","You can redeem any experience gained as an antagonist here to any character. Come back when you've played an antagonist role!"))

	return .