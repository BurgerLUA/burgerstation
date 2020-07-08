mob/living/on_right_down(object,location,control,params)
	return src.attack(src,object,params)

mob/living/on_left_down(object,location,control,params)
	return src.attack(src,object,params)

mob/living/get_examine_list(var/mob/examiner)

	. = ..()

	var/final_pronoun = "They"
	if(examiner == src)
		final_pronoun = "You"

	if(health)
		if(health.damage[TOX] >= 25)
			. += div("warning","[final_pronoun] look a bit sickly.")

		if(health.damage[OXY] >= 25)
			. += div("warning","[final_pronoun] look a bit pale.")

		if(health.damage[BRUTE] + health.damage[BURN] >= 25)
			. += div("warning","[final_pronoun] look hurt.")

	if(has_status_effect(CRIT))
		. += list(div("danger","[final_pronoun] do not appear to be breathing."))

	if(examiner == src)
		for(var/status in status_effects)
			var/status_effect/S = SSstatus.all_status_effects[status]
			. += list(div("danger",S.desc))

	if(dead)
		if(client)
			. += list(div("warning","[final_pronoun] lay dead and lifeless."))
		else
			. += list(div("danger","[final_pronoun] lay dead and lifeless, and their soul has departed..."))
	else if(ai && ai.use_alerts)
		switch(ai.alert_level)
			if(ALERT_LEVEL_NONE)
				. += list(div("notice","They do not appear to notice you."))
			if(ALERT_LEVEL_NOISE)
				. += list(div("warning","They seem to be looking for a source of noise."))
			if(ALERT_LEVEL_CAUTION)
				. += list(div("warning","They seem to be looking for someone."))
			if(ALERT_LEVEL_COMBAT)
				. += list(div("danger","They appear to be in a combative stance!"))
	return .