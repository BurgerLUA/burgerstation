/ai/advanced/unsc
	enemy_tags = list("Syndicate","Covenant")
	should_find_weapon = TRUE
	roaming_distance = 8
	aggression = 1
	assistance = 1

	var/language_to_use = LANGUAGE_BASIC

/ai/advanced/unsc/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(damage_amount >= 10 && . && prob(25))
		if(prob(10) && get_dist(owner,attacker) >= 3)
			var/attack_dir = dir2text(get_dir(owner,attacker))
			owner.do_say("Taking fire from the [attack_dir]!")
		else
			var/list/responses = list(
				"Are you mentally handicapped?",
				"Taking fire!",
				"Bet you i can stick it!",
				"They got my [atom_damaged.name]!",
				"They hit me in the [atom_damaged.name]!",
				"Aww this sucks",
				"Fuck! I'm hit!",
				"I'm gonna die...I KNOW i'm gonna die!"
			)
			owner.do_say(pick(responses),language_to_use = language_to_use)

	return .


/ai/advanced/unsc/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

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
				"You had to be the hero, huh? Well now you're dead. Now you're a dead hero",
				"That's the last of them.",
				"Any more?",
				"Better you then me",
				"We just got our asses kicked!"
			)
		else if(old_alert_level == ALERT_LEVEL_CAUTION && new_alert_level == ALERT_LEVEL_COMBAT)
			responses = list(
				"I was going for the Triple!",
				"Come get me! I'm just a little coward!",
				"Confirmed enemy!",
				"Found the enemy!",
				"Ma-an, you're shooting like you got a cheatcode."
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


/ai/advanced/unsc/lobby
	active = TRUE