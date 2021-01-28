/ai/advanced/clockwork_cult


/ai/advanced/clockwork_cult/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(damage_amount >= 10 && . && prob(25))
		var/list/responses = list(
			"Ratvar will protect me!",
			"Your soul will become one with Ratvar!",
			"Revenge for Ratvar will be soon!",
			"To the cogs, with you!"
		)
		owner.do_say(pick(responses),language_to_use = LANGUAGE_CLOCKWORK)

	return .

/ai/advanced/clockwork_cult/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	. = ..()

	if(. && prob(25))
		var/list/responses = list()
		if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_CAUTION)
			responses = list(
				"They hide from the light.",
				"We must drag them into the light...",
				"The light will take you soon...",
				"Where do they hide?"
			)
		else if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_NONE)
			responses = list(
				"Your soul will be worthy.",
				"Ratvar use you.",
				"Soon you will join us.",
				"A sacrifice for Ratvar."
			)
		else if(old_alert_level == ALERT_LEVEL_CAUTION && new_alert_level == ALERT_LEVEL_COMBAT)
			responses = list(
				"Into the light you go!",
				"You will serve Ratvar!",
				"A sacrifice for him!",
				"I will drag you to the cogs if I have to!"
			)
		else if(old_alert_level == ALERT_LEVEL_NONE && new_alert_level == ALERT_LEVEL_NOISE)
			responses = list(
				"A soul is near.",
				"I hear a soul...",
				"Is that a soul?",
				"What was that? A soul?"
			)
		else if(new_alert_level == ALERT_LEVEL_NOISE)
			responses = list(
				"Did they run? Did they cower?",
				"Where is that noise?",
				"Come into the light...",
				"The light shall take you soon..."
			)
		else if(new_alert_level == ALERT_LEVEL_NONE)
			responses = list(
				"Nothing.",
				"No soul here."
			)

		if(length(responses))
			owner.do_say(pick(responses),,language_to_use = LANGUAGE_CLOCKWORK)

	return .