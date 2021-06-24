/mob/proc/get_sound_volume(var/volume=100,var/channel=1)

	var/local_volume = volume
	if(client.settings)
		local_volume *= client.settings.loaded_data["volume_master"] / 100
		switch(channel)
			if(SOUND_CHANNEL_MUSIC)
				local_volume *= client.settings.loaded_data["volume_music"] / 100
			if(SOUND_CHANNEL_AMBIENT)
				local_volume *= client.settings.loaded_data["volume_ambient"] / 100
			if(SOUND_CHANNEL_FOOTSTEPS)
				local_volume *= client.settings.loaded_data["volume_footsteps"] / 100
			if(SOUND_CHANNEL_UI)
				local_volume *= client.settings.loaded_data["volume_ui"] / 100
			if(SOUND_CHANNEL_FX)
				local_volume *= client.settings.loaded_data["volume_fx"] / 100

	return local_volume