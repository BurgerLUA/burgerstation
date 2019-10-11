
/mob/living/advanced/player/on_life()

	if(area && !area.safe)
		var/was_protected = spawn_protection > 0
		spawn_protection =  max(0,spawn_protection - LIFE_TICK)
		if(!spawn_protection && was_protected)
			src.to_chat(span("notice","Your spawn protection has worn off."))

	if(logout_time && logout_time >= curtime + SECONDS_TO_DECISECONDS(MINUTES_TO_SECONDS(60))) //Timeout
		logout_time = 0
		qdel(src)

	return ..()

/mob/living/advanced/player/pre_death()
	. = ..()
	save()
	return .

/mob/living/advanced/player/post_death()

	world.log << "[src] has died!"

	var/list/people_who_contributed = list()
	var/list/people_who_killed = list()
	var/list/people_who_killed_names = list()

	for(var/list/attack_log in attack_logs)
		if(attack_log["lethal"])
			var/mob/living/advanced/player/P = attack_log["attacker"]
			people_who_killed += P
			people_who_killed_names += P.name

		if(!attack_log["lethal"] && attack_log["critical"])
			people_who_contributed += attack_log["attacker"]

	var/date = get_date()
	var/time = get_time()

	if(last_words && length(people_who_killed) && people_who_killed[1] && people_who_killed[1] != src)
		SS_Soapstone.create_new_soapstone(get_turf(src),SOUTH,"#000000",src.real_name,src.ckey,last_words,date,time)

	for(var/mob/living/advanced/player/P in people_who_killed)

		if(!P.client || !P.mobdata) //Something something exploitable something something
			continue

		var/karma_gain = calculate_karma_gain_for_attacker(P,src)

		world.log << "Karma Gain: [karma_gain]."

		if(karma_gain > 0)
			karma_gain *= 1/length(people_who_killed)

		if(do_karma_event(P,src,karma_gain))
			punish_player(P)

		world.log << "[P] killed [src]."

	attack_logs = list()

	return ..()

/proc/punish_player(var/mob/living/advanced/player/P)

	var/punishment_level = -P.mobdata.loaded_data["karma"]

	world.log << punishment_level

	return TRUE

/proc/do_karma_event(var/mob/living/advanced/player/attacker,var/mob/living/advanced/player/victim,var/karma_gain = 0)

	var/old_victim_justice_broken = victim.mobdata.loaded_data["justice_broken"]
	victim.mobdata.loaded_data["justice_broken"] = 0

	victim.mobdata.loaded_data["karma"] -= karma_gain*0.5
	attacker.mobdata.loaded_data["karma"] += karma_gain

	//The player killed someone evil
	if(karma_gain > 0)

		attacker.mobdata.loaded_data["justice_served"] += 1
		var/attacker_justice_served = attacker.mobdata.loaded_data["justice_served"]
		var/attacker_justice_reward = attacker.mobdata.loaded_data["justice_reward_claimed"]

		attacker.to_chat(span("notice","You hear a voice in your head..."))

		var/bonus_text = "Continue killing those who defy the natural order, and you shall be rewarded."

		if(attacker_justice_served == 5 && attacker_justice_reward < 5)
			bonus_text = "You've done well for yourself. Speak to the one who calles themselves Bar-Shaleez to recieve a reward..."
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
				attacker.to_chat(span("karma","Fool. You will pay for that..."))
				return TRUE
			if(2)
				attacker.to_chat(span("karma","You wish to be punished again? So be it. Continue on this path and there will be nothing but darkness awaiting you."))
				return TRUE
			if(3)
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

	var/attacker_karma = attacker.mobdata.loaded_data["karma"]
	var/victim_karma = victim.mobdata.loaded_data["karma"]

	var/gained_karma = 0

	if(attacker_karma < 0) //The attacker is not without sin
		gained_karma = Clamp(-victim_karma*0.5 + attacker_karma,0,1000)
	else if(victim_karma > 0) //The victim is without sin
		gained_karma = min(-1000,-attacker_karma*0.5,-victim_karma*0.25)
	else //The attacker is without sin, and the victim is with sin
		gained_karma = min(1000,-victim_karma * 0.25)

	return gained_karma