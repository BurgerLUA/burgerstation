/client/proc/update_window()

	if(settings && settings.loaded_data && settings.loaded_data["hud_colors"])
		var/color_scheme = settings.loaded_data["hud_colors"]
		winset(src,"main.input","background-color=[color_scheme[3]]")
		winset(src,"main.splitter","background-color=[color_scheme[1]]")
		winset(src,"chat.tab","background-color=[color_scheme[2]]")
		winset(src,"control.splitter","background-color=[color_scheme[1]]")
		winset(src,"info.info","background-color=[color_scheme[1]];tab-background-color=[color_scheme[2]]")
		return TRUE

	return FALSE