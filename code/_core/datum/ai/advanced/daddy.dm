/ai/advanced/daddy
	var/next_chat_time = 0
	guard = TRUE

/ai/advanced/daddy/handle_current_objectives(var/tick_rate)

	. = ..()

	if(objective_attack && next_chat_time <= world.time)
		var/list/possible_phrases = list(
			"HE'S BACK.",
			"48 VITALITY. 66 ENDURANCE. 12 ATTUNEMENT. 16 FUCKING STRENGTH.",
			"GIANTS. GIANTS. GIANTS.",
			"STAMINA. HEALTH. ENDURANCE. EVERYTHING YOU COULD EVER WANT.",
			"WELL, WHAT IS IT?"
		)
		owner.do_say(pick(possible_phrases))
		next_chat_time = world.time + 5 SECONDS

/ai/advanced/daddy/attack_message()
	owner.do_say("POW.")
