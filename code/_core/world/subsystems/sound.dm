var/global/list/active_sounds = list()

SUBSYSTEM_DEF(sound)
	name = "Sound Subsystem"
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_PRELOAD

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
	created_sound.status = SOUND_MUTE
	created_sound.channel = SOUND_CHANNEL_AMBIENT
	hearer << created_sound

proc/stop_music_track(var/client/hearer)
	var/sound/created_sound = sound()
	created_sound.priority = 100
	created_sound.status = SOUND_MUTE
	created_sound.channel = SOUND_CHANNEL_MUSIC
	hearer << created_sound
	hearer.next_music_track = 0

proc/play_ambient_sound(var/sound_path,var/atom/hearer,var/volume=1,var/pitch=1,var/loop=0,var/pan=0,var/echo=0,var/environment=ENVIRONMENT_NONE)
	var/sound/created_sound = sound(sound_path)

	if(!created_sound)
		LOG_ERROR("Warning! Invalid sound: [sound_path].")
		return FALSE

	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.pan = pan
	created_sound.channel = SOUND_CHANNEL_AMBIENT
	created_sound.priority = 0
	created_sound.echo = echo
	created_sound.environment = environment
	created_sound.status = 0
	created_sound.volume = volume
	created_sound.status = SOUND_STREAM

	hearer << created_sound

proc/play_music_track(var/music_track_id,var/client/hearer,var/volume=25)

	stop_music_track(hearer)

	var/track/T = all_tracks[music_track_id]
	if(!T)
		CRASH("WARNING: INVALID MUSIC TRACK: [music_track_id].")
		return FALSE

	var/volume_mod = 50

	if(hearer.settings && hearer.settings.loaded_data)
		volume_mod = hearer.settings.loaded_data["volume_music"]

	var/sound/created_sound = sound(T.path)

	if(!created_sound)
		LOG_ERROR("Warning! Invalid sound: [T.path].")
		return FALSE

	created_sound.channel = SOUND_CHANNEL_MUSIC
	created_sound.priority = 0
	created_sound.environment = ENVIRONMENT_NONE
	created_sound.status = 0
	created_sound.volume = volume * (volume_mod/100)
	created_sound.status = SOUND_STREAM

	hearer << created_sound
	hearer.current_music_track = music_track_id
	hearer.next_music_track = curtime + SECONDS_TO_DECISECONDS(T.length)

	return created_sound

var/global/channel_hack = 100

/proc/play_sound(var/sound_path, var/list/atom/hearers = list(), var/list/pos = list(0,0,-1), var/volume=100, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/environment = ENVIRONMENT_NONE, var/invisibility_check = 0, var/range_min=1, var/range_max = SOUND_RANGE)

	if(!sound_path)
		return FALSE

	var/sound/created_sound = sound(sound_path)

	if(!created_sound)
		LOG_ERROR("Warning! Invalid sound: [sound_path].")
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
			LOG_ERROR("WARNING: For some reason, [M] cannot hear the sound ([sound_path]) as it is deleted!")
			return FALSE

		if(!M.client || !M.client.settings)
			continue

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

		M << created_sound

	return created_sound