/client/proc/update_verbs()
	CLEAR_VERBS(src)
	add_inherent_verbs()
	if(mob)
		CLEAR_VERBS(mob)
		mob.add_inherent_verbs()
	return TRUE

/client/proc/add_inherent_verbs()

	//Menu
	verbs += /client/verb/open_discord
	verbs += /client/verb/open_github
	verbs += /client/verb/open_patreon
	verbs += /client/verb/player_who
	verbs += /client/verb/staff_who

	//Settings
	verbs += /client/verb/change_click_mode
	verbs += /client/verb/set_volume_footsteps
	verbs += /client/verb/set_volume_music
	verbs += /client/verb/set_volume_ambient
	verbs += /client/verb/set_volume_fx
	verbs += /client/verb/set_volume_master
	verbs += /client/verb/toggle_fullscreen
	verbs += /client/verb/set_fps
	verbs += /client/verb/edit_macros
	verbs += /client/verb/set_view_range
	verbs += /client/verb/precise_zoom

	//Controls
	verbs += /client/verb/button_release
	verbs += /client/verb/button_press
	verbs += /client/verb/focus_input
	verbs += /client/verb/focus_map
	verbs += /client/verb/toggle_focus

	//Chat
	verbs += /client/verb/pm
	verbs += /client/verb/ooc

	verbs += /client/verb/refactor_savedata

	//Game
	verbs += /client/verb/stop_sound
	verbs += /client/verb/ghost
	verbs += /client/verb/check_objectives

	//Admin
	if(permissions & FLAG_PERMISSION_MODERATOR)
		verbs += /client/verb/make_announcement
		verbs += /client/verb/rtv
		verbs += /client/verb/set_skill
		verbs += /client/verb/set_attribute
		verbs += /client/verb/give_dosh
		verbs += /client/verb/ban
		verbs += /client/verb/force_random_event
		verbs += /client/verb/create_vote

	//Dev
	if(permissions & FLAG_PERMISSION_DEVELOPER)
		verbs += /client/verb/air_test
		verbs += /client/verb/var_edit
		verbs += /client/verb/change_variable
		verbs += /client/verb/spawn_from_path
		verbs += /client/verb/add_new_wikibot_entry
		verbs += /client/verb/make_war
		verbs += /client/verb/generate_map_icon
		verbs += /client/verb/stealth_test
		verbs += /client/verb/test_round_end
		verbs += /client/verb/check_lights
		verbs += /client/verb/subsystem_report
		verbs += /client/verb/reload_badwords
		verbs += /client/verb/force_save_all
		verbs += /client/verb/rejuvenate_player
		verbs += /client/verb/stress_test
		verbs += /client/verb/print_dps

	return TRUE