/client/proc/update_verbs()
	CLEAR_VERBS(src)
	add_inherent_verbs()
	if(mob)
		CLEAR_VERBS(mob)
		mob.add_inherent_verbs()
	return TRUE

/client/proc/add_inherent_verbs()
	verbs += /client/verb/ooc
	verbs += /client/verb/toggle_focus
	verbs += /client/verb/focus_map
	verbs += /client/verb/focus_input
	verbs += /client/verb/button_press
	verbs += /client/verb/button_release
	verbs += /client/verb/fullscreen
	if(ENABLE_ATMOS)
		verbs += /client/verb/air_test
	return TRUE