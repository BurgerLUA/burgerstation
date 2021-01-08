/ai/advanced/syndicate
	enemy_tags = list("NanoTrasen")
	should_find_weapon = TRUE
	aggression = 1
	retaliate = TRUE

	var/language_to_use = LANGUAGE_BASIC


/ai/advanced/syndicate/stress_test

/ai/advanced/syndicate/stress_test/handle_movement()
	owner.move_dir = pick(DIRECTIONS_ALL)
	return TRUE

/ai/advanced/syndicate/russian
	language_to_use = LANGUAGE_RUSSIAN

/ai/advanced/syndicate/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(damage_amount >= 10 && . && prob(25))
		if(prob(10) && get_dist(owner,attacker) >= 3)
			var/attack_dir = dir2text(get_dir(owner,attacker))
			owner.do_say("Taking fire from the [attack_dir]!")
		else
			var/list/responses = list(
				"I'm hit!",
				"Taking fire!",
				"They got me!",
				"They got my [atom_damaged.name]!",
				"They hit me in the [atom_damaged.name]!",
				"Taking fire, need assistance!",
				"Fuck! I'm hit!"
			)
			owner.do_say(pick(responses),language_to_use = language_to_use)

	return .


/ai/advanced/syndicate/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	. = ..()

	if(. && prob(25))
		var/list/responses = list()
		if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_CAUTION)
			responses = list(
				"I don't see them...",
				"Lost sight of them.",
				"No enemy in sight.",
				"They there?"
			)
		else if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_NONE)
			responses = list(
				"Enemy down.",
				"They're dead.",
				"That's the last of them.",
				"Any more?"
			)
		else if(old_alert_level == ALERT_LEVEL_CAUTION && new_alert_level == ALERT_LEVEL_COMBAT)
			responses = list(
				"Found you!",
				"I knew I heard something!",
				"Confirmed enemy!",
				"Found the enemy!"
			)
		else if(old_alert_level == ALERT_LEVEL_NONE && new_alert_level == ALERT_LEVEL_NOISE)
			responses = list(
				"You hear that?",
				"What was that?",
				"Did you hear something?",
				"Wait. What was that?"
			)
		else if(new_alert_level == ALERT_LEVEL_NOISE)
			responses = list(
				"I know I heard something...",
				"Where are you?",
				"Come out... where are you?",
				"I swear I heard something..."
			)
		else if(new_alert_level == ALERT_LEVEL_NONE)
			responses = list(
				"Nothing here. Resuming patrols.",
				"Resuming patrols."
			)

		if(length(responses))
			owner.do_say(pick(responses),language_to_use = language_to_use)

	return .