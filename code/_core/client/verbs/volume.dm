/client/verb/set_volume_master(var/desired_volume as num)
	set category = "Preferences"
	set name = "Volume - Master"
	settings.change_setting("volume_master",desired_volume)

/client/verb/set_volume_fx(var/desired_volume as num)
	set category = "Preferences"
	set name = "Volume - Effects"
	settings.change_setting("volume_fx",desired_volume)

/client/verb/set_volume_ambient(var/desired_volume as num)
	set category = "Preferences"
	set name = "Volume - Ambient"
	settings.change_setting("volume_ambient",desired_volume)

/client/verb/set_volume_music(var/desired_volume as num)
	set category = "Preferences"
	set name = "Volume - Music"
	settings.change_setting("volume_music",desired_volume)

/client/verb/set_volume_footsteps(var/desired_volume as num)
	set category = "Preferences"
	set name = "Volume - Footsteps"
	settings.change_setting("volume_footsteps",desired_volume)