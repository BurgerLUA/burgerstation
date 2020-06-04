/client/verb/toggle_fullscreen()
	set hidden = TRUE

	var/is_fullscreen = winget(src, "main", "can-close") == "false"
	is_fullscreen = !is_fullscreen

	winset(src,"main","can-close=[is_fullscreen ? "false" : "true"]")
	winset(src,"main","can-resize=[is_fullscreen ? "false" : "true"]")
	winset(src,"main","can-minimize=[is_fullscreen ? "false" : "true"]")
	winset(src,"menu.view.fullscreen","checked=[is_fullscreen ? "true" : "false"]")
	winset(src,"main","titlebar=[is_fullscreen ? "false" : "true"]")
	winset(src,"main","is-pane=[is_fullscreen ? "true" : "false"]")

	if(is_fullscreen)
		winset(src,"main","is-maximized=false")
		sleep(1)
		winset(src,"main","is-maximized=true")

/client/verb/stop_sound()
	set name = "Stop Sounds"
	set category = "Game"
	mob << sound(null)
	to_chat("All sounds have been stopped.")

/client/verb/set_volume_master(var/desired_volume as num)
	set hidden = TRUE
	settings.change_setting("volume_master",desired_volume)
	stop_sound()

/client/verb/set_volume_fx(var/desired_volume as num)
	set hidden = TRUE
	settings.change_setting("volume_fx",desired_volume)
	stop_sound()

/client/verb/set_volume_ambient(var/desired_volume as num)
	set hidden = TRUE
	settings.change_setting("volume_ambient",desired_volume)
	stop_sound()

/client/verb/set_volume_music(var/desired_volume as num)
	set hidden = TRUE
	settings.change_setting("volume_music",desired_volume)
	stop_sound()

/client/verb/set_volume_footsteps(var/desired_volume as num)
	set hidden = TRUE
	settings.change_setting("volume_footsteps",desired_volume)
	stop_sound()

/client/verb/change_click_mode()
	set hidden = TRUE
	swap_mouse = !swap_mouse
	if(swap_mouse)
		to_chat(span("ui notice","Right clicking will now activate the object in your right hand, and vice versa."))
	else
		to_chat(span("ui notice","Left clicking will now activate the object in your right hand, and vice versa."))


/client/verb/set_fps(var/desired_fps as num)
	set hidden = TRUE
	var/old_fps = src.fps
	desired_fps = clamp(desired_fps,30,60)
	src.fps = desired_fps
	settings.change_setting("fps_client",desired_fps)
	to_chat(span("notice","Your FPS was changed from [old_fps] to [desired_fps]."))