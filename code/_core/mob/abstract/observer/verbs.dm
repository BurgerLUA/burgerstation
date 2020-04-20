/mob/abstract/observer/add_inherent_verbs()
	verbs += /mob/abstract/observer/verb/new_character
	verbs += /mob/abstract/observer/verb/load_character
	verbs += /mob/abstract/observer/verb/load_most_recent_character
	return ..()