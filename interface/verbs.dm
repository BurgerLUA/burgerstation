/client/verb/fullscreen()

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

/client/verb/toggle_focus()
	var/is_focused = winget(src, "map.map", "focus") == "true"
	winset(src,"map.map","focus=[is_focused ? "false" : "true"]")
	winset(src,"main.input","focus=[is_focused ? "true" : "false"]")

/client/verb/focus_map()
	winset(src,"map.map","focus=true")
	winset(src,"main.input","focus=false")

/client/verb/focus_input()
	winset(src,"map.map","focus=false")
	winset(src,"main.input","focus=true")