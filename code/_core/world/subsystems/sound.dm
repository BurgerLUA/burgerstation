var/global/list/active_sounds = list()

SUBSYSTEM_DEF(sound)
	name = "Sound Subsystem"
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_PRELOAD
	var/channel_hack = 0

/subsystem/sound/on_life()
	for(var/F in active_sounds)
		var/sound/S = F
		if(active_sounds[S] == -1)
			continue
		active_sounds[S] -= 1
		if(active_sounds[S] > 0)
			continue
		S.status = SOUND_MUTE | SOUND_UPDATE
		for(var/mob/M in all_mobs_with_clients)
			if(!M.client)
				continue
			M.client.receive_sound(S)
		active_sounds -= S
		qdel(S)

	return TRUE

/proc/stop_sound(var/sound_path,var/list/mob/hearers)
	for(var/F in active_sounds)
		var/sound/S = F
		if(S.file != sound_path)
			continue
		S.status = SOUND_MUTE
		for(var/mob/M in hearers)
			if(!M.client)
				continue
			M.client.receive_sound(S)

proc/stop_ambient_sounds(var/mob/M)
	if(!M.client)
		return FALSE
	var/sound/created_sound = sound()
	created_sound.priority = 100
	created_sound.status = SOUND_MUTE
	created_sound.channel = SOUND_CHANNEL_AMBIENT
	M.client.receive_sound(created_sound)
	M.client.current_ambient_sound = null
	return TRUE

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

	for(var/mob/M in hearers)
		if(M.client)
			if(M.client.current_ambient_sound == sound_path)
				continue
			M.client.current_ambient_sound = sound_path
		created_sound.volume = M.client.settings.loaded_data["volume_ambient"]
		M.client.receive_sound(created_sound)

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

	for(var/mob/M in hearers)
		if(!M.client)
			continue
		created_sound.volume = M.client.settings.loaded_data["volume_ambient"]
		M.client.receive_sound(created_sound)

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

/proc/get_mobs_in_range(var/range,var/atom/epicenter=usr)
	. = list()
	for(var/mob/M in range(range,epicenter))
		. += M
	return .

/proc/get_clients_in_range(var/range,var/atom/epicenter=usr)

	. = list()
	for(var/mob/M in all_mobs_with_clients)
		if(get_dist(epicenter,M) > range)
			continue
		. += M
	return .

//Example Formats
/*
play('sound',mob) to play to that mob only
play('sound, atom) to play to all turfs in range of that atom(add args range_min,range_max)
play('sound',list_of_hearers, turf or vector) to play to that list of hearers at that location
*/

/proc/play(var/sound_path = null, var/location_or_list = null, var/sound_source = null, var/range_min=1, var/range_max = SOUND_RANGE, var/volume=50, var/sound_setting = SOUND_SETTING_FX, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/invisibility_check = 0, var/alert=0, var/atom/alert_source = null)

	if(!sound_path || !location_or_list ||!SSsound)
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
		hearers += get_clients_in_range(range_max,AT)
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
			CRASH_SAFE("Could not find a turf to play sound ([sound_path])!")
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

		hearers -= M

		if(!created_sound)
			log_error("WARNING: For some reason, [M] cannot hear the sound ([sound_path]) as it is deleted!")
			return FALSE

		var/turf/T = get_turf(M)
		if(!T)
			continue

		var/client/C = M.client

		if(C && ismob(C.eye))
			M = C.eye

		if(length(pos) && pos[3] != 0 && pos[3] != T.z) //0 just means that it should play locally
			continue

		if(invisibility_check && M.see_invisible < invisibility_check)
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

		if(C && C.settings)
			local_volume *= C.settings.loaded_data["volume_master"] / 100
			switch(channel)
				if(SOUND_CHANNEL_MUSIC)
					local_volume *= C.settings.loaded_data["volume_music"] / 100
				if(SOUND_CHANNEL_AMBIENT)
					local_volume *= C.settings.loaded_data["volume_ambient"] / 100
				if(SOUND_CHANNEL_FOOTSTEPS)
					local_volume *= C.settings.loaded_data["volume_footsteps"] / 100
				if(SOUND_CHANNEL_UI)
					local_volume *= C.settings.loaded_data["volume_ui"] / 100
				if(SOUND_CHANNEL_FX)
					local_volume *= C.settings.loaded_data["volume_fx"] / 100

		if(local_volume <= 0)
			continue

		created_sound.volume = local_volume

		if(C) C.receive_sound(created_sound)

	if(length(hearers))
		CRASH_SAFE("Warning: Found [length(hearers)] non-mobs in a hearers list.")

	return created_sound