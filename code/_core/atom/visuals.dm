/atom/proc/set_opacity(var/new_opacity)
	if(new_opacity != opacity)
		//var/old_opacity = opacity
		opacity = new_opacity
		//GLOB.opacity_set_event.raise_event(src, old_opacity, new_opacity) TODO:What the fuck is this?
		return TRUE
	else
		return FALSE