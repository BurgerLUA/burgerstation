var/global/list/active_sounds = list()

/subsystem/sound/
	name = "Sound Subsystem"
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_SOUND

/subsystem/sound/on_life()
	for(var/F in active_sounds)
		var/sound/S = F
		if(active_sounds[S] != -1)
			active_sounds[S] -= 1
			if(active_sounds[S] <= 0)
				S.status = SOUND_MUTE | SOUND_UPDATE
				for(var/mob/M in all_mobs_with_clients)
					M << S
				active_sounds -= S
				qdel(S)
				continue

	return TRUE

/proc/stop_sound(var/sound_path,var/list/atom/hearers)
	for(var/F in active_sounds)
		var/sound/S = F
		if(S.file == sound_path)
			S.status = SOUND_MUTE
			for(var/atom/H in hearers)
				H << S

proc/stop_ambient_sounds(var/atom/hearer)
	var/sound/created_sound = sound()
	created_sound.priority = 100
	//created_sound.status = SOUND_MUTE
	//hearer << created_sound

proc/play_ambient_sound(var/sound_path,var/atom/hearer,var/volume=1,var/pitch=1,var/loop=0,var/pan=0,var/echo=0,var/environment=ENVIRONMENT_GENERIC)

	var/sound/created_sound = sound(sound_path)
	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.pan = pan
	created_sound.channel = SOUND_CHANNEL_AMBIENT
	created_sound.priority = 0
	created_sound.echo = echo
	created_sound.environment = environment
	created_sound.status = 0
	created_sound.volume = volume

	hearer << created_sound

/proc/play_sound(var/sound_path, var/list/atom/hearers = list(), var/list/pos = list(0,0,0), var/volume=100, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=0, var/priority=0, var/echo = 0, var/environment = ENVIRONMENT_GENERIC, var/invisibility_check = 0)
	var/sound/created_sound = sound(sound_path)

	//created_sound.volume = volume
	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.pan = pan
	created_sound.channel = channel
	created_sound.priority = priority
	created_sound.echo = echo
	created_sound.environment = environment
	created_sound.status = 0

	if(loop)
		active_sounds[created_sound] = -1
	else if(duration)
		active_sounds[created_sound] = duration

	for(var/mob/M in hearers)
		if(!M.client)
			continue

		if(invisibility_check && M.see_invisible < invisibility_check)
			continue

		var/local_volume = volume

		if(created_sound.z >= 0)
			created_sound.x = pos[1] - M.x
			created_sound.y = pos[2] - M.y
			created_sound.z = pos[3] - M.z

			if(channel != SOUND_CHANNEL_MUSIC)
				var/distance_mod = max(0,VIEW_RANGE - sqrt(created_sound.x**2 + created_sound.y**2))/VIEW_RANGE
				local_volume *= distance_mod

		if(local_volume <= 0)
			continue

		created_sound.volume = local_volume

		M << created_sound

	return created_sound