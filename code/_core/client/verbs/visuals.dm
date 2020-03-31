/client/verb/set_client_fps(var/desired_fps as num)
	set category = "Preferences"
	set name = "Maximum FPS"
	var/old_fps = src.fps
	desired_fps = clamp(desired_fps,30,60)
	src.fps = desired_fps
	settings.change_setting("fps_client",desired_fps)
	to_chat(span("notice","Your FPS was changed from [old_fps] to [desired_fps]."))