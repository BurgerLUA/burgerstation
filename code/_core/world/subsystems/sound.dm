var/global/list/active_sounds = list()

SUBSYSTEM_DEF(sound)
	name = "Sound Subsystem"
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_PRELOAD
	var/channel_hack = 0

/subsystem/sound/on_life()
	for(var/F in active_sounds)
		var/sound/S = F
		if(active_sounds[S] != -1)
			active_sounds[S] -= 1
			if(active_sounds[S] <= 0)
				S.status = SOUND_MUTE | SOUND_UPDATE
				for(var/mob/M in all_mobs_with_clients)
					M.receive_sound(S)
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
				H.receive_sound(S)

proc/stop_ambient_sounds(var/atom/hearer)
	var/sound/created_sound = sound()
	created_sound.priority = 100
	created_sound.status = SOUND_MUTE
	created_sound.channel = SOUND_CHANNEL_AMBIENT
	hearer.receive_sound(created_sound)
	if(ismob(hearer))
		var/mob/M = hearer
		if(M.client)
			M.client.current_ambient_sound = null

proc/stop_music_track(var/client/hearer)
	var/sound/created_sound = sound()
	created_sound.priority = 100
	created_sound.status = SOUND_MUTE
	created_sound.channel = SOUND_CHANNEL_MUSIC
	hearer.receive_sound(created_sound)
	hearer.next_music_track = 0

proc/play_ambient_sound(var/sound_path,var/list/atom/hearers,var/volume=50,var/pitch=1,var/loop=0,var/pan=0,var/echo=0,var/environment=ENVIRONMENT_NONE)

	var/sound/created_sound = sound(sound_path)

	if(!created_sound)
		log_error("Warning! Invalid sound: [sound_path].")
		return FALSE

	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.pan = pan
	created_sound.channel = SOUND_CHANNEL_AMBIENT
	created_sound.priority = 0
	created_sound.echo = echo
	created_sound.environment = environment
	created_sound.status = SOUND_STREAM

	for(var/atom/A in hearers)
		var/final_volume = volume
		if(ismob(A))
			var/mob/M = A
			if(M.client)
				if(M.client.current_ambient_sound == sound_path)
					continue
				M.client.current_ambient_sound = sound_path
			final_volume = M.client.settings.loaded_data["volume_ambient"]
		created_sound.volume = final_volume
		A.receive_sound(created_sound)

proc/play_random_ambient_sound(var/sound_path,var/list/atom/hearers,var/volume=50,var/pitch=1,var/loop=0,var/pan=0,var/echo=0,var/environment=ENVIRONMENT_NONE)
	var/sound/created_sound = sound(sound_path)

	if(!created_sound)
		log_error("Warning! Invalid sound: [sound_path].")
		return FALSE

	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.pan = pan
	created_sound.channel = SOUND_CHANNEL_AMBIENT_RANDOM
	created_sound.priority = 0
	created_sound.echo = echo
	created_sound.environment = environment
	created_sound.status = SOUND_STREAM

	for(var/atom/A in hearers)
		var/final_volume = volume
		if(ismob(A))
			var/mob/M = A
			final_volume = M.client.settings.loaded_data["volume_ambient"]
		created_sound.volume = final_volume
		A.receive_sound(created_sound)

proc/play_music_track(var/music_track_id,var/client/hearer,var/volume=25)

	stop_music_track(hearer)

	var/track/T = all_tracks[music_track_id]
	if(!T)
		CRASH_SAFE("WARNING: INVALID MUSIC TRACK: [music_track_id].")
		return FALSE

	var/volume_mod = 50

	if(hearer.settings && hearer.settings.loaded_data)
		volume_mod = hearer.settings.loaded_data["volume_music"]

	var/sound/created_sound = sound(T.path)

	if(!created_sound)
		log_error("Warning! Invalid sound: [T.path].")
		return FALSE

	created_sound.channel = SOUND_CHANNEL_MUSIC
	created_sound.priority = 0
	created_sound.environment = ENVIRONMENT_NONE
	created_sound.status = 0
	created_sound.volume = volume * (volume_mod/100)
	created_sound.status = SOUND_STREAM

	hearer.receive_sound(created_sound)
	hearer.current_music_track = music_track_id
	hearer.next_music_track = world.time + SECONDS_TO_DECISECONDS(T.length)

	return created_sound

/mob/proc/get_sound_environment()
	var/area/A = get_area(src)
	return A.sound_environment

//Example Formats
/*
play('sound',mob) to play to that mob only
play('sound, atom) to play to all turfs in range of that atom(add args range_min,range_max)
play('sound',list_of_hearers, turf or vector) to play to that list of hearers at that location
*/

/proc/play(var/sound_path = null, var/location_or_list = null, var/sound_source = null, var/range_min=1, var/range_max = SOUND_RANGE, var/volume=50, var/sound_setting = SOUND_SETTING_FX, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/invisibility_check = 0, var/alert=0, var/atom/alert_source = null)

	if(!sound_path || !location_or_list)
		return FALSE

	var/list/hearers = list()
	var/list/pos = list()

	if(islist(location_or_list))
		hearers = location_or_list
	else if(ismob(location_or_list))
		hearers += location_or_list
	else if(is_atom(location_or_list))
		var/atom/A = location_or_list
		var/turf/AT = get_turf(A)
		for(var/mob/M in mobs_in_range(range_max,AT))
			hearers += M
		if(!sound_source)
			sound_source = AT
	else
		hearers = all_mobs_with_clients

	if(islist(sound_source))
		pos = sound_source
	else if(ismob(sound_source))
		var/mob/M = sound_source
		if(!M.client)
			return FALSE
	else if(sound_source)
		if(isturf(sound_source))
			var/turf/T = sound_source
			pos = vector(T.x,T.y,T.z)
		else
			CRASH_SAFE("sound_source ([sound_source]) is not a turf or a list so it cannot play.")
			return FALSE
	else if(is_atom(location_or_list))
		var/turf/T = get_turf(location_or_list)
		if(!T)
			CRASH_SAFE("Could not find a turf to play this sound!")
			return FALSE
		pos = vector(T.x,T.y,T.z)

	var/sound/created_sound = sound(sound_path)
	if(!created_sound)
		CRASH_SAFE("Invalid sound: [sound_path].")
		return FALSE

	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.priority = priority
	created_sound.echo = echo
	//environment is handled by the hearer
	created_sound.status = 0
	created_sound.wait = 0
	created_sound.channel = SSsound.channel_hack
	SSsound.channel_hack++
	if(SSsound.channel_hack > 1024)
		SSsound.channel_hack = 100

	if(duration > 0)
		active_sounds[created_sound] = duration
	else if(loop)
		active_sounds[created_sound] = -1

	for(var/mob/M in hearers)

		CHECK_TICK

		if(length(pos) && pos[3] != 0 && pos[3] != M.z) //0 just means that it should play locally
			continue

		if(!created_sound)
			log_error("WARNING: For some reason, [M] cannot hear the sound ([sound_path]) as it is deleted!")
			return FALSE

		if(invisibility_check && M.see_invisible < invisibility_check)
			continue

		var/turf/T = get_turf(M)
		if(!T)
			continue

		created_sound.environment = M.get_sound_environment()

		var/local_volume = volume
		if(length(pos))
			created_sound.x = pos[1] - T.x
			created_sound.z = pos[2] - T.y
			created_sound.y = 0
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

		if(alert && is_living(M) && luck(alert_source,created_sound.volume*3,FALSE))
			var/mob/living/L = M
			if(L.ai && L.ai.alert_level != ALERT_LEVEL_COMBAT)
				CALLBACK("alert_level_change_\ref[src]",CEILING(L.ai.reaction_time*0.1,1),L.ai,/ai/proc/set_alert_level,alert,FALSE,alert_source)

		M.receive_sound(created_sound)

	return created_sound