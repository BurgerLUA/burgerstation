/client/verb/set_volume_master(var/desired_volume as num)
	set category = "Volume"
	set name = "Master Volume"
	settings.change_setting("volume_master",desired_volume)

/client/verb/set_volume_fx(var/desired_volume as num)
	set category = "Volume"
	set name = "Effects Volume"
	settings.change_setting("volume_fx",desired_volume)

/client/verb/set_volume_ambient(var/desired_volume as num)
	set category = "Volume"
	set name = "Ambient Volume"
	settings.change_setting("volume_ambient",desired_volume)

/client/verb/set_volume_music(var/desired_volume as num)
	set category = "Volume"
	set name = "Music Volume"
	settings.change_setting("volume_music",desired_volume)

/client/verb/set_volume_footsteps(var/desired_volume as num)
	set category = "Volume"
	set name = "Footsteps Volume"
	settings.change_setting("volume_footsteps",desired_volume)