/mob/living/add_inherent_verbs()

	verbs += /mob/living/verb/cycle_intent_clockwise
	verbs += /mob/living/verb/cycle_intent_counter_clockwise
	verbs += /mob/living/verb/sneak


	return ..()

/mob/living/verb/sneak()
	set hidden = TRUE
	toggle_sneak(!is_sneaking)