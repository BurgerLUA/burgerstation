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
	verbs += /client/verb/toggle_smooth_shadows
	verbs += /client/verb/toggle_depth
	verbs += /client/verb/toggle_currency_bloom

	//Controls
	verbs += /client/verb/button_release
	verbs += /client/verb/button_press
	verbs += /client/verb/focus_input
	verbs += /client/verb/focus_map
	verbs += /client/verb/toggle_focus

	//Chat
	verbs += /client/verb/pm
	verbs += /client/verb/ooc

	//Game
	verbs += /client/verb/stop_sound
	verbs += /client/verb/ghost
	verbs += /client/verb/check_objectives

	if(permissions & FLAG_PERMISSION_HOST)
		verbs += /client/verb/apply_fuckup

	//Moderator/Admin
	if(permissions & FLAG_PERMISSION_MODERATOR || permissions & FLAG_PERMISSION_ADMIN)
		verbs += /client/verb/ban
		verbs += /client/verb/get_clients
		verbs += /client/verb/jump_to_player
		verbs += /client/verb/jump_to_area
		verbs += /client/verb/jump_to_client
		verbs += /client/verb/jump_to_mob
		verbs += /client/verb/adjust_nightvision
		verbs += /client/verb/bring_player
		verbs += /client/verb/ic_announcement
		verbs += /client/verb/rejuvenate
		verbs += /client/verb/ooc_announcement

	if(permissions & FLAG_PERMISSION_ADMIN)
		verbs += /client/verb/force_round_end
		verbs += /client/verb/force_random_event
		verbs += /client/verb/force_specific_event
		verbs += /client/verb/force_vote
		verbs += /client/verb/add_points
		verbs += /client/verb/create_explosion
		verbs += /client/verb/smite_living
		verbs += /client/verb/spawn_from_path

	//Dev
	if(permissions & FLAG_PERMISSION_DEVELOPER)
		verbs += /client/verb/show_debug_verbs
		verbs += /client/verb/add_new_wikibot_entry

	if(permissions & FLAG_PERMISSION_GAMEMASTER)
		verbs += /client/verb/speed_up_setup
		verbs += /client/verb/set_skill
		verbs += /client/verb/set_attribute
		verbs += /client/verb/give_credits
		verbs += /client/verb/test_spook_station
		verbs += /client/verb/test_syndicate_raid
		verbs += /client/verb/add_language
		verbs += /client/verb/remove_language
		verbs += /client/verb/remove_trait
		verbs += /client/verb/add_trait


	return TRUE