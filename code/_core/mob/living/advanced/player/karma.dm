/proc/punish_player(var/mob/living/advanced/player/P)

	var/karma_difference = abs(P.karma - initial(P.karma))

	var/punishment_level = clamp(CEILING(karma_difference/1000, 1),3,50)

	var/list/turf/valid_turfs = list()

	for(var/turf/simulated/floor/F in range(5,P))
		valid_turfs += F

	for(var/i=1,i<=min(punishment_level,10),i++)
		var/mob/living/simple/npc/silicon/squats/S = new(pick(valid_turfs),null,punishment_level)
		S.Initialize()
		if(S.ai)
			var/ai/simple/karma_borg/KB_AI = S.ai
			KB_AI.true_target = P

	return TRUE

/proc/do_karma_event(var/mob/living/advanced/player/attacker,var/mob/living/advanced/player/victim,var/karma_gain = 0)

	var/old_victim_justice_broken = victim.mobdata.loaded_data["justice_broken"]
	victim.mobdata.loaded_data["justice_broken"] = 0

	attacker.karma += karma_gain

	//The player killed someone evil
	if(karma_gain > 0)

		attacker.mobdata.loaded_data["justice_served"] += 1
		var/attacker_justice_served = attacker.mobdata.loaded_data["justice_served"]
		var/attacker_justice_reward = attacker.mobdata.loaded_data["justice_reward_claimed"]

		attacker.to_chat(span("notice","You hear a voice in your head..."))

		var/bonus_text = "Continue killing those who defy the natural order, and you shall be rewarded."

		if(attacker_justice_served == 5 && attacker_justice_reward < 5)
			bonus_text = "You've done well for yourself. Speak to the one who calles themselves Bar-Shaleez to receive a reward..."
		else if(attacker_justice_served == 10 && attacker_justice_reward < 10)
			bonus_text = "You carry out my will quite efficiently for a mortal. Bar-Shaleez will have a reward waiting for you."
		else if(attacker_justice_served == 15 && attacker_justice_reward < 15)
			bonus_text = "You surpass some of my best followers. Speak to Bar-Shaleez for a reward worth your stature."
		else if(attacker_justice_served == 25 && attacker_justice_reward < 25)
			bonus_text = "You surpass some of my best followers. Speak to Bar-Shaleez for a reward worth your stature."

		if(old_victim_justice_broken)
			attacker.to_chat(span("karma","\The [victim.real_name] has been judged for their sins for the murder of [old_victim_justice_broken] innocent\s. [bonus_text]"))
		else
			attacker.to_chat(span("karma","\The [victim.real_name] has been judged for their sins for their past life. [bonus_text]"))

		if(old_victim_justice_broken > 0)
			victim.to_chat(span("notice","You hear a voice in your head..."))
			victim.to_chat(span("karma","Fool. I told you to repent. You no longer have my favor."))
			victim.mobdata.loaded_data["justice_served"] = 0

		return FALSE

	//The player killed someone nice
	if(karma_gain < 0)

		attacker.mobdata.loaded_data["justice_broken"] += 1

		attacker.to_chat(span("notice","You hear a voice in your head..."))

		if(attacker.mobdata.loaded_data["justice_served"] >= 1 || attacker.mobdata.loaded_data["justice_broken"] == 1)
			attacker.to_chat(span("karma","You dare defy me? I shall assume that this was a mistake just this once. Repent for your sins now, or else suffering shall await."))
			return FALSE

		switch(attacker.mobdata.loaded_data["justice_broken"])
			if(1)
				attacker.to_chat(span("karma","Fool. You will pay for that!"))
				return TRUE
			if(2)
				attacker.to_chat(span("karma","Fool. You will pay for that..."))
				return TRUE
			if(3)
				attacker.to_chat(span("karma","You wish to be punished again? So be it. Continue on this path and there will be nothing but darkness awaiting you."))
				return TRUE
			if(4)
				attacker.to_chat(span("karma","You have made an enemy out of me. Repent and regain my favor, or I shall send nothing but more death your way."))
				attacker.mobdata.loaded_data["justice_served"] = 0
				return TRUE
			else
				attacker.to_chat(span("karma","Enjoy the wraith of my minions, mortal."))
				return TRUE

	if(attacker.mobdata.loaded_data["justice_served"] > 1)
		attacker.to_chat(span("notice","You hear a voice in your head..."))
		attacker.to_chat(span("karma","\The [victim.real_name] was not guilty enough to warrant my praise... seek out better prey."))

	return FALSE

/proc/calculate_karma_gain_for_attacker(var/mob/living/advanced/player/attacker,var/mob/living/advanced/player/victim)

	if(!attacker.mobdata || !victim.mobdata)
		return 0

	var/attacker_karma = attacker.karma
	var/victim_karma = victim.karma
	var/gained_karma = 0

	if(victim_karma <= 0 && attacker_karma <= 0) //We're both shit.
		gained_karma = clamp(-victim_karma*0.5 + attacker_karma,0,1000)
	else if(victim_karma > 0 && attacker_karma <= 0) //The victim is good but the attacker is shit.
		gained_karma = min(-1000,-victim_karma*0.25)
	else if (victim_karma <= 0 && attacker_karma > 0) //The victim is shit but the attacker is good.
		gained_karma = min(10000,-attacker_karma*0.25)
	else if (victim_karma > 0 && attacker_karma > 0) //We're both good.
		gained_karma = max(-1000.-attacker_karma*0.5,-victim_karma*0.5)

	return round(gained_karma,1)