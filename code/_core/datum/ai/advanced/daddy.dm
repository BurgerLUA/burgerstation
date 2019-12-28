/ai/advanced/daddy

	radius_find_enemy = VIEW_RANGE*2

	objective_delay = 5
	attack_delay = 1
	movement_delay = 1

	target_distribution_y = list(8,16,16,16,16,32,32,32)


/ai/advanced/daddy/hostile_message()
	owner.say("THE LEGEND NEVER DIES.")


/ai/advanced/daddy/handle_objectives()

	. = ..()

	if(prob(10))
		var/list/possible_phrases = list(
			"HE'S BACK.",
			"48 VITALITY. 66 ENDURANCE. 12 ATTUNEMENT. 16 FUCKING STRENGTH.",
			"GIANTS. GIANTS. GIANTS.",
			"STAMINA. HEALTH. ENDURANCE. EVERYTHING YOU COULD EVER WANT.",
			"WELL, WHAT IS IT?"
		)


		owner.say(pick(possible_phrases))

	return .

/ai/advanced/daddy/attack_message()
	owner.say("POW.")
