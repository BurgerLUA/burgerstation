/*
/proc/play_sound(var/sound_path, var/list/atom/hearers = list(), var/list/pos = list(0,0,-1), var/volume=100, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/environment = ENVIRONMENT_NONE, var/invisibility_check = 0, var/range_min=1, var/range_max = SOUND_RANGE, var/alert=0)

	if(!sound_path)
		return FALSE

	var/sound/created_sound = sound(sound_path)

	if(!created_sound)
		log_error("Warning! Invalid sound: [sound_path].")
		return FALSE

	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.pan = pan
	created_sound.priority = priority
	created_sound.echo = echo
	created_sound.environment = environment
	created_sound.status = 0
	created_sound.wait = 0
	created_sound.channel = channel_hack
	channel_hack++
	if(channel_hack > 1024)
		channel_hack = 100

	if(loop)
		active_sounds[created_sound] = -1
	else if(duration > 0)
		active_sounds[created_sound] = duration

	if(!hearers)
		hearers = all_mobs_with_clients

	for(var/mob/M in hearers)

		CHECK_TICK

		if(!created_sound)
			log_error("WARNING: For some reason, [M] cannot hear the sound ([sound_path]) as it is deleted!")
			return FALSE

		if(invisibility_check && M.see_invisible < invisibility_check)
			continue

		var/turf/T = get_turf(M)

		if(!T)
			continue

		var/local_volume = volume

		if(pos[3] >= 0)
			created_sound.x = pos[1] - T.x
			created_sound.y = pos[2] - T.y
			created_sound.z = pos[3] - T.z
			if(channel != SOUND_CHANNEL_MUSIC && channel != SOUND_CHANNEL_AMBIENT)
				var/distance = max(0,sqrt(created_sound.x**2 + created_sound.y**2)-(VIEW_RANGE*0.5)) - range_min
				local_volume = (local_volume - distance*0.25)*max(0,range_max - distance)/range_max
				if(local_volume <= 0)
					continue
		else
			created_sound.x = 0
			created_sound.y = 0
			created_sound.z = 0

		if(M.client && M.client.settings)
			local_volume *= M.client.settings.loaded_data["volume_master"] / 100

			switch(channel)
				if(SOUND_CHANNEL_MUSIC)
					local_volume *= M.client.settings.loaded_data["volume_music"] / 100
				if(SOUND_CHANNEL_AMBIENT)
					local_volume *= M.client.settings.loaded_data["volume_ambient"] / 100
				if(SOUND_CHANNEL_FOOTSTEPS)
					local_volume *= M.client.settings.loaded_data["volume_footsteps"] / 100
				if(SOUND_CHANNEL_UI)
					local_volume *= M.client.settings.loaded_data["volume_ui"] / 100
				if(SOUND_CHANNEL_FX)
					local_volume *= M.client.settings.loaded_data["volume_fx"] / 100

		if(local_volume <= 0)
			continue

		created_sound.volume = local_volume

		if(alert && is_living(M) && prob(created_sound.volume*2))
			var/mob/living/L = M
			if(L.ai && L.ai.set_alert_level(alert) && L.ai.alert_level != ALERT_LEVEL_COMBAT)
				var/turf/T2 = locate(pos[1],pos[2],pos[3])
				M.set_dir(get_dir(M,T2))
				if(!L.ai.objective_move)
					L.ai.set_move_objective(T2)

		if(M.client)
			M << created_sound

	return created_sound
*/