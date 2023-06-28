/client/proc/update_window()

	if(settings && settings.loaded_data && settings.loaded_data["hud_colors"])
		var/color_scheme = settings.loaded_data["hud_colors"]

		var/dark = color_scheme[1]
		var/normal = color_scheme[2]
		var/light = color_scheme[3]
		var/white = color_scheme[4]
		//var/bad = color_scheme[5]

		winset(src,"chat.tab","text-color=[white];background-color=[normal];tab-background-color=[normal];tab-text-color=[white]")

		winset(src,"chat_all.output","style='body{background-color:[white];}[STYLESHEET]'")
		winset(src,"chat_combat.output","style='body{background-color:[white];}[STYLESHEET]'")
		winset(src,"chat_looc.output","style='body{background-color:[white];}[STYLESHEET]'")
		winset(src,"chat_ooc.output","style='body{background-color:[white];}[STYLESHEET]'")
		winset(src,"chat_debug.output","style='body{background-color:[white];}[STYLESHEET]'")
		winset(src,"chat_say.output","style='body{background-color:[white];}[STYLESHEET]'")

		winset(src,"control.input","text-color=[white]")
		winset(src,"control.wiki","background-color=[light];text-color=[white]")
		winset(src,"control.discord","background-color=[light];text-color=[white]")
		winset(src,"control.github","background-color=[light];text-color=[white]")
		winset(src,"control.patreon","background-color=[light];text-color=[white]")
		winset(src,"control.splitter","background-color=[dark]")

		winset(src,"info.info","text-color=[white];background-color=[dark];tab-background-color=[normal];tab-text-color=[white]")
		winset(src,"main.splitter","background-color=[dark]")

		focus_map()

		return TRUE

	return FALSE