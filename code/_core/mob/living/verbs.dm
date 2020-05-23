/mob/living/add_inherent_verbs()

	verbs += /mob/living/verb/cycle_intent_clockwise
	verbs += /mob/living/verb/cycle_intent_counter_clockwise
	verbs += /mob/living/verb/sneak
	verbs += /mob/living/verb/set_intent_harm
	verbs += /mob/living/verb/set_intent_disarm
	verbs += /mob/living/verb/set_intent_grab
	verbs += /mob/living/verb/set_intent_help


	return ..()

/mob/living/verb/sneak()
	set hidden = TRUE
	toggle_sneak(!is_sneaking)