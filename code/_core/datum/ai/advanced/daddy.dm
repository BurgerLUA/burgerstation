/ai/advanced/daddy

	objective_delay = 5
	attack_delay = 1


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
