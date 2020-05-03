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
	verbs += /client/verb/change_click_mode
	verbs += /client/verb/set_volume_master
	verbs += /client/verb/set_volume_fx
	verbs += /client/verb/set_volume_ambient
	verbs += /client/verb/set_volume_music
	verbs += /client/verb/set_volume_footsteps
	verbs += /client/verb/ghost
	verbs += /client/proc/edit_macros
	if(ENABLE_ATMOS)
		verbs += /client/verb/air_test
	if(ckey == "burgerbb")
		verbs += /client/verb/add_new_wikibot_entry
		verbs += /client/verb/rtv

	return TRUE