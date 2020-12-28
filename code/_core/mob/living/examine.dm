/mob/living/proc/get_damage_description(var/mob/examiner,var/verbose=FALSE)

	. = list()


	if(health)

		var/noun //Custom shit
		if(examiner == src)
			noun = "You look"
		else
			switch(gender)
				if(MALE)
					noun = "He looks"
				if(FEMALE)
					noun = "She looks"
				else
					noun = "They look"

		switch(health.damage[TOX])
			if(5 to 15)
				. += div("warning","<i>[noun] off color.</i>")
			if(15 to 25)
				. += div("warning","[noun] sickly.")
			if(25 to 50)
				. += div("warning","<b>[noun] ailing.</b>")
			if(50 to INFINITY)
				. += div("warning","<u><b>[noun] diseased.</u></b>")

		switch(health.damage[PAIN])
			if(15 to 25)
				. += div("warning","[noun] sore.")
			if(25 to 50)
				. += div("warning","<b>[noun] pained.</b>")
			if(50 to INFINITY)
				. += div("warning","<u><b>[noun] hurting.</u></b>")

	return .


/mob/living/get_examine_list(var/mob/examiner)

	. = ..()

	var/activity_text = get_activity_text()
	if(activity_text)
		. += activity_text

	. += get_damage_description(examiner,FALSE)

	return .


/mob/living/proc/get_activity_text()

	if(dead)
		if(ai || is_player_controlled())
			return div("danger","They are dead...")
		else
			return div("warning","They are dead and lifeless, and their soul has departed...")
	else if(!ai)
		if(ckey_last && !client)
			return div("warning","They seem to be affected by space sleep disorder. They may recover soon.")
		else if(client && client.inactivity >= SECONDS_TO_TICKS(60))
			return div("warning","They seem to be blanking out for [TICKS_TO_SECONDS(client.inactivity)] seconds. They may snap out of it soon.")

	return null

/mob/living/get_examine_details_list(var/mob/examiner)

	. = ..()

	var/pronoun = get_pronoun_he_she_it(src)

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