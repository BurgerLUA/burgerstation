mob/living/get_examine_details_list(var/mob/examiner)

	. = ..()

	var/pronoun = get_pronoun(src)

	if(ai && ai.use_alerts)
		switch(ai.alert_level)
			if(ALERT_LEVEL_NONE)
				. += list(div("notice","[capitalize(pronoun)] does not appear to notice you."))
			if(ALERT_LEVEL_NOISE)
				. += list(div("warning","[capitalize(pronoun)] seems to be looking for a source of noise."))
			if(ALERT_LEVEL_CAUTION)
				. += list(div("warning","[capitalize(pronoun)] seems to be looking for someone."))
			if(ALERT_LEVEL_COMBAT)
				. += list(div("danger","[capitalize(pronoun)] appears to be in a combative stance, with intent to fight [ai.objective_attack]!"))

	return .