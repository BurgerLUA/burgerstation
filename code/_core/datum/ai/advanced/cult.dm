/ai/advanced/cult


/ai/advanced/cult/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(damage_amount >= 10 && . && prob(25))
		var/list/responses = list(
			"You'll pay!",
			"Blood for the blood god!",
			"Death to you!",
			"My blood returns!"
		)
		owner.do_say(pick(responses),language_to_use = LANGUAGE_CULT)

	return .

/ai/advanced/cult/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	. = ..()

	if(. && prob(25))
		var/list/responses = list()
		if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_CAUTION)
			responses = list(
				"They are in the shadows.",
				"Where must they be?",
				"I do not see...",
				"Where do they hide?"
			)
		else if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_NONE)
			responses = list(
				"Another one for the blood god.",
				"A sacrifice complete!",
				"Death and destruction.",
				"Excellent sacrifice."
			)
		else if(old_alert_level == ALERT_LEVEL_CAUTION && new_alert_level == ALERT_LEVEL_COMBAT)
			responses = list(
				"You hide no longer!",
				"I see your doom!",
				"A worthy sacrifice!",
				"I found you!"
			)
		else if(old_alert_level == ALERT_LEVEL_NONE && new_alert_level == ALERT_LEVEL_NOISE)
			responses = list(
				"Something is near...",
				"Do you hear life?",
				"Something approaches.",
				"I hear..."
			)
		else if(new_alert_level == ALERT_LEVEL_NOISE)
			responses = list(
				"I do not doubt my eyes or ears.",
				"Death is soon...",
				"Make this quick...",
				"The shadows do not belong to you..."
			)
		else if(new_alert_level == ALERT_LEVEL_NONE)
			responses = list(
				"Nothing. Wasted efforts.",
				"A waste of time."
			)

		if(length(responses))
			owner.do_say(pick(responses),,language_to_use = LANGUAGE_CULT)

	return .