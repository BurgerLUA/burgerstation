/command/preferences/


/command/preferences/verb/fullscreen()

	set name = "Toggle Fullscreen"
	set category = "Preferences"

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


/command/preferences/verb/set_volume_master(var/desired_volume as num)
	set category = "Preferences"
	set name = "Volume - Master"
	settings.change_setting("volume_master",desired_volume)

/command/preferences/verb/set_volume_fx(var/desired_volume as num)
	set category = "Preferences"
	set name = "Volume - Effects"
	settings.change_setting("volume_fx",desired_volume)

/command/preferences/verb/set_volume_ambient(var/desired_volume as num)
	set category = "Preferences"
	set name = "Volume - Ambient"
	settings.change_setting("volume_ambient",desired_volume)

/command/preferences/verb/set_volume_music(var/desired_volume as num)
	set category = "Preferences"
	set name = "Volume - Music"
	settings.change_setting("volume_music",desired_volume)

/command/preferences/verb/set_volume_footsteps(var/desired_volume as num)
	set category = "Preferences"
	set name = "Volume - Footsteps"
	settings.change_setting("volume_footsteps",desired_volume)