
mob/living/get_examine_list(var/mob/examiner)

	. = ..()

	if(dead)
		if(ai || is_player_controlled())
			. += div("danger","They are dead...")
		else
			. += div("warning","They are dead and lifeless, and their soul has departed...")
	else if(!ai)

		if(!is_player_controlled())
			. += div("warning","They are totally catonic. Any recovery is unlikely.")
		else if(!client)
			. += div("warning","They seem to be affected by space sleep disorder. They may recover soon.")
		else if(client.inactivity >= SECONDS_TO_TICKS(60))
			. += div("warning","They seem to be blanking out for [TICKS_TO_SECONDS(client.inactivity)] seconds. They may snap out of it soon.")





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