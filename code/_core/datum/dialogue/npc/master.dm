/dialogue/npc/master/

/dialogue/npc/master/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Welcome to the #1. Are you here to be recruited into our #2? Perhaps you're here for #3 or #4.",
		"*Recruitment Office",
		"*Prestige Program",
		"*Reward Redemption",
		"*Experience Redemption"
	)

	.["*Recruitment Office"] = list(
		"This here is the recruitment office. This is where we recruit extraordinary NanoTrasen Operatives for use in special programs, like the #1. Are you interested in such?",
		"*Prestige Program"
	)

	.["*Prestige Program"] = list(
		"The Prestige Program, or PP for short, is an experimental and questionably legal brain surgery procedure that alters certain areas of the brain to be more compact \
		to allow a broader understanding of the subject. As a consequence, you'll have to relearn everything you know, but once you've done so, you'll be smarter in the subject matter! NEWLINENEWLINE\
		So, are you ready to be a part of the Prestige Program? Only masters of a skill can participate! NEWLINENEWLINE\
		#1 NEWLINE\
		#2",
		"*Yes, enter the prestige program",
		"*No, do not enter the prestige program"
	)

	.["*No, do not enter the prestige program"] = list("That's a shame. You can enter the program at any time you wish.")

	.["*Yes, enter the prestige program"] = list("...")

	.["*Reward Redemption"] = list(
		"Please whisper the secret phrase to redeem your reward."
	)
	.["*Experience Redemption"] = list(
		"Select what experience you wish to redeem."
	)

	.["*rewardfail"] = list(
		"It appears you did not enter a valid reward code.",
	)

	.["*rewardsuccess"] = list(
		"Enjoy your reward!",
	)

/dialogue/npc/master/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	switch(topic)
		if("*Yes, enter the prestige program")
			P.dialogue_target_id = null
			close_menu(P,/menu/dialogue/)
			try_prestige(P)
		if("*Reward Redemption")
			var/desired_input = input("Please enter the reward code. Reward codes are case sensitive.","Reward Code") as text
			desired_input = sanitize(desired_input)
			if(desired_input && SSreward.check_code(P.client,desired_input))
				set_topic(P,"*rewardsuccess")
			else
				set_topic(P,"*rewardfail")
		if("*Experience Redemption")
			var/savedata/client/globals/G = GLOBALDATA(P.ckey)
			if(!G)
				P.to_chat(span("danger","Your global data appears to be bugged! Report this to burger on discord!"))
				return FALSE
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



/dialogue/npc/master/proc/try_prestige(var/mob/living/advanced/player/P)

	var/list/valid_skills = list()

	for(var/k in P.skills)
		var/experience/E = P.skills[k]
		if(E.get_max_level() > E.get_current_level())
			continue
		valid_skills += E

	if(!length(valid_skills))
		P.to_chat(span("warning","You have no valid skills to prestige! Come back when one of your skills is above the prestige threshold."))
		return FALSE

	valid_skills += "Cancel"

	var/desired_choice = input("Are you sure you wish to enter the prestige program? The chosen skill will be reset to 5 and its max level will increase by 5.","Prestige Program","Cancel") as null|anything in valid_skills
	if(!desired_choice || desired_choice == "Cancel")
		P.to_chat(span("notice","You decide not to prestige anything."))
		return FALSE

	var/experience/E = desired_choice
	if(E.get_max_level() <= E.get_current_level())
		P.prestige(E.id)
	return TRUE