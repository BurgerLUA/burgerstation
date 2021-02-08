/client/verb/edit_macros()
	set hidden = TRUE


	var/list/unused_commands = list()
	var/list/building = QWERTY_MACROS
	for(var/k in building)
		var/v = building[k]
		unused_commands += v

	var/html_to_send = "<h1>Controls</h1><h3>I unironically made this in like 2 hours so please be gentle.</h3>"

	for(var/key in macros.macros)
		var/command = macros.macros[key]
		html_to_send += "<a href='?change_key=[key]'>[key]: [command]</a><br>"
		unused_commands -= command
	html_to_send += "<hr>"
	html_to_send += "<p>Unused commands: [english_list(unused_commands)].</p>"
	html_to_send += "<hr>"
	html_to_send += "<a href='?change_key=new'>Add New Bind</a><br>"
	html_to_send += "<a href='?change_key=QWERTY'>Reset to Factory Default (QWERTY)</a><br>"
	html_to_send += "<a href='?change_key=AZERTY'>Reset to Factory Default (AZERTY)</a><br>"
	html_to_send += "<a href='?change_key=save'>Save Settings to Stored File</a><br>"
	html_to_send += "<a href='?change_key=load'>Load Settings from Stored File</a><br>"
	html_to_send += "<a href='?change_key=quit'>Quit</a><br>"

	var/id = "edit_macros"
	//winclone(src, "window", id)
	winset(src, "browser([id])", "parent=map;type=browser;size=0x0;anchor1=0,0;anchor2=100,100")
	winshow(src,"browser([id])",TRUE)
	src << output(html_to_send, "browser([id])")

/client/verb/set_fps(var/desired_fps as num)
	set hidden = TRUE
	var/old_fps = clamp(src.fps,FPS_SERVER,FPS_CLIENT)
	desired_fps = clamp(desired_fps,FPS_SERVER,FPS_CLIENT)
	to_chat(span("notice","Your FPS was changed from [old_fps] to [desired_fps]."))
	if(desired_fps == FPS_SERVER)
		desired_fps = 0
	src.fps = desired_fps
	settings.change_setting("fps_client",desired_fps)

/client/verb/set_view_range(var/desired_view_range as num)
	set hidden = TRUE
	var/old_view_range = view
	settings.change_setting("view_range",desired_view_range)
	update_view_range()
	to_chat(span("notice","Your view range was changed from [old_view_range] to [view]."))


/client/verb/precise_zoom()
	set hidden = TRUE

	if(precise_zoom)
		update_zoom(CEILING(zoom_level,1))
		to_chat(span("notice","You disable precise zooming."))
		precise_zoom = FALSE
	else
		to_chat(span("notice","You enable precise zooming."))
		precise_zoom = TRUE

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