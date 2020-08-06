
mob/living/get_examine_list(var/mob/examiner)

	. = ..()

	if(dead)
		if(client)
			. += div("danger","They are dead...")
		else
			. += div("warning","They are dead and lifeless, and their soul has departed...")

	return .

mob/living/get_examine_details_list(var/mob/examiner)

	. = ..()

	var/pronoun = get_pronoun(src)

	if(ai && ai.use_alerts)
		switch(ai.alert_level)
			if(ALERT_LEVEL_NONE)
				. += div("notice","[capitalize(pronoun)] does not appear to notice you.")
			if(ALERT_LEVEL_NOISE)
				. += div("warning","[capitalize(pronoun)] seems to be looking for a source of noise.")
			if(ALERT_LEVEL_CAUTION)
				. += div("warning","[capitalize(pronoun)] seems to be looking for someone.")
			if(ALERT_LEVEL_COMBAT)
				. += div("danger","[capitalize(pronoun)] appears to be in a combative stance, with intent to fight [ai.objective_attack]!")

	return .