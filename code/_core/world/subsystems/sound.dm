#define ROUND_END_DIRECTORY "sound/round_end/"

SUBSYSTEM_DEF(sound)
	name = "Sound Subsystem"
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_PRELOAD
	var/channel_hack = 100

	cpu_usage_max = 75
	tick_usage_max = 75

	var/list/round_end_sounds = list()

	var/list/active_sounds = list()

	var/list/sound_cache = list()

/subsystem/sound/unclog(var/mob/caller)
	for(var/k in src.active_sounds)
		var/sound/S = k
		qdel(S)
		active_sounds -= k
	broadcast_to_clients(span("danger","Removed all active sounds."))
	return ..()

/subsystem/sound/Initialize()
	var/found_files = flist(ROUND_END_DIRECTORY)
	for(var/k in found_files)
		round_end_sounds += "[ROUND_END_DIRECTORY][k]"
	log_subsystem(name,"Found [length(round_end_sounds)] round end sounds.")
	return TRUE

/subsystem/sound/proc/process_sound(var/sound/S)
	if(active_sounds[S] == -1)
		return FALSE
	active_sounds[S] -= 1
	if(active_sounds[S] > 0)
		return FALSE
	S.status = SOUND_MUTE | SOUND_UPDATE
	for(var/k in all_clients)
		var/client/C = k
		C << S
	active_sounds -= S
	return TRUE

/subsystem/sound/on_life()
	for(var/F in active_sounds)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		var/sound/S = F
		if(!process_sound(S))
			log_error("Warning! Could not properly process an active sound!")
			active_sounds -= F

	return TRUE

/proc/stop_sound(var/sound_path,var/list/mob/hearers)
	for(var/F in SSsound.active_sounds)
		CHECK_TICK(SSsound.tick_usage_max,FPS_SERVER)
		var/sound/S = F
		if(S.file != sound_path)
			continue
		S.status = SOUND_MUTE
		for(var/k in hearers)
			var/mob/M = k
			if(!M.client)
				continue
			M.client << S

proc/stop_ambient_sounds(var/mob/M)
	if(!M.client)
		return FALSE
	var/sound/created_sound = sound()
	created_sound.priority = 100
	created_sound.status = SOUND_MUTE
	created_sound.channel = SOUND_CHANNEL_AMBIENT
	M.client << created_sound
	M.client.current_ambient_sound = null
	return TRUE

proc/stop_music_track(var/client/hearer)
	var/sound/created_sound = sound()
	created_sound.priority = 100
	created_sound.status = SOUND_MUTE
	created_sound.channel = SOUND_CHANNEL_MUSIC
	hearer << created_sound
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

	for(var/k in hearers)
		var/mob/M = k
		CHECK_TICK(50,FPS_SERVER*10)
		if(M.client)
			if(M.client.current_ambient_sound == sound_path)
				continue
			M.client.current_ambient_sound = sound_path
		created_sound.volume = M.client.settings.loaded_data["volume_ambient"]
		M.client << created_sound

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

	for(var/k in hearers)
		var/mob/M = k
		CHECK_TICK(50,FPS_SERVER*10)
		if(!M.client)
			continue
		created_sound.volume = M.client.settings.loaded_data["volume_ambient"]
		M.client << created_sound

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

	hearer << created_sound
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
	for(var/k in all_mobs_with_clients)
		var/mob/M = k
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

/proc/setup_sound(var/sound_path)

	if(!SSsound || !SSsound.initialized)
		return FALSE

	var/sound/created_sound

	if(SSsound.sound_cache[sound_path])
		created_sound = SSsound.sound_cache[sound_path]
	else
		created_sound = sound(sound_path)
		if(!created_sound)
			CRASH_SAFE("Error: Invalid sound! [sound_path].")
			return null
		SSsound.sound_cache[sound_path] = created_sound

	return created_sound


/proc/play_sound_target(var/sound_path,var/mob/M,var/range_min=1, var/range_max = SOUND_RANGE, var/volume=50, var/sound_setting = SOUND_SETTING_FX, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/invisibility_check = 0)

	var/sound/created_sound = setup_sound(sound_path)
	if(!created_sound || volume <= 0)
		return FALSE

	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.priority = priority
	created_sound.echo = echo
	created_sound.channel = SSsound.channel_hack
	SSsound.channel_hack += 1
	if(SSsound.channel_hack > 1024)
		SSsound.channel_hack = 100

	if(duration > 0)
		SSsound.active_sounds[created_sound] = duration
	else if(loop)
		SSsound.active_sounds[created_sound] = -1

	if(!created_sound)
		log_error("WARNING: For some reason, [M] cannot hear the sound ([sound_path]) as it is deleted!")
		return FALSE

	if(invisibility_check && M.see_invisible < invisibility_check)
		return null

	if(!M.client || !M.client.eye)
		return null

	var/client/C = M.client

	var/local_volume = volume
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
		return null

	created_sound.x = 0
	created_sound.z = 0
	created_sound.y = 0
	created_sound.volume = local_volume

	C << created_sound

	return C

/proc/play_sound_global(var/sound_path,var/list/hearers=all_mobs_with_clients,var/range_min=1, var/range_max = SOUND_RANGE, var/volume=50, var/sound_setting = SOUND_SETTING_FX, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/invisibility_check = 0)

	var/sound/created_sound = setup_sound(sound_path)
	if(!created_sound || volume <= 0)
		log_error("Warning: Invalid sound: [sound_path]!")
		return FALSE

	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.priority = priority
	created_sound.echo = echo
	created_sound.channel = SSsound.channel_hack
	SSsound.channel_hack++
	if(SSsound.channel_hack > 1024)
		SSsound.channel_hack = 100
	created_sound.x = 0
	created_sound.z = 0
	created_sound.y = 0

	if(duration > 0)
		SSsound.active_sounds[created_sound] = duration
	else if(loop)
		SSsound.active_sounds[created_sound] = -1

	for(var/k in hearers)
		var/mob/M = k

		CHECK_TICK(SSsound.tick_usage_max,FPS_SERVER*2)

		if(invisibility_check && M.see_invisible < invisibility_check) continue

		if(!M.client || !M.client.eye) continue

		var/client/C = M.client

		created_sound.environment = M.get_sound_environment()

		var/local_volume = volume
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

		C << created_sound

	return created_sound



/proc/play_sound(var/sound_path,var/turf/source_turf,var/list/hearers,var/range_min=1, var/range_max = SOUND_RANGE, var/volume=50, var/sound_setting = SOUND_SETTING_FX, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/invisibility_check = 0)

	var/sound/created_sound = setup_sound(sound_path)
	if(!created_sound || volume <= 0)
		log_error("Warning: Invalid sound: [sound_path]!")
		return FALSE
	if(!source_turf)
		CRASH_SAFE("Warning: play_sound passed source_turf as null!")
		return FALSE

	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.priority = priority
	created_sound.echo = echo
	created_sound.channel = SSsound.channel_hack

	SSsound.channel_hack++
	if(SSsound.channel_hack > 1024)
		SSsound.channel_hack = 100

	if(duration > 0)
		SSsound.active_sounds[created_sound] = duration
	else if(loop)
		SSsound.active_sounds[created_sound] = -1

	if(!hearers)
		hearers = all_mobs_with_clients_by_z["[source_turf.z]"]

	for(var/k in hearers)

		CHECK_TICK(SSsound.tick_usage_max,FPS_SERVER*2)

		var/mob/M = k

		if(!M.client || !M.client.eye)
			continue

		if(invisibility_check && M.see_invisible < invisibility_check)
			continue

		var/local_volume = volume
		if(M.client.settings)
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

		var/turf/mob_turf = get_turf(M)
		if(channel != SOUND_CHANNEL_MUSIC && channel != SOUND_CHANNEL_AMBIENT)
			var/distance = max(0,get_dist(mob_turf,source_turf)-(VIEW_RANGE*0.5)) - range_min
			if(sound_setting == SOUND_SETTING_FOOTSTEPS && distance <= 0)
				distance = 4
			local_volume = (local_volume - distance*0.25)*max(0,range_max - distance)/range_max
			if(local_volume <= 0)
				continue

		created_sound.x = source_turf.x - mob_turf.x
		created_sound.z = source_turf.y - mob_turf.y
		created_sound.y = 0
		created_sound.volume = local_volume
		created_sound.environment = M.get_sound_environment()
		M.client << created_sound

	return created_sound



/*
/proc/play(var/sound_path = null, var/location_or_list = null, var/sound_source = null, var/range_min=1, var/range_max = SOUND_RANGE, var/volume=50, var/sound_setting = SOUND_SETTING_FX, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/invisibility_check = 0)

	if(!SSsound)
		log_error("Tried playing a sound without the sound subsystem active!")
		return FALSE

	if(!sound_path)
		CRASH_SAFE("Tried playing a sound without a sound path!")
		return FALSE

	if(!location_or_list)
		CRASH_SAFE("Tried playing a sound \"[sound_path]\" without a target!")
		return FALSE

	var/list/hearers = list()
	var/list/pos = list()

	if(islist(location_or_list))
		var/list/NL = location_or_list
		hearers = NL.Copy()
	else if(ismob(location_or_list))
		hearers += location_or_list
	else if(is_atom(location_or_list))
		var/atom/A = location_or_list
		var/turf/AT = get_turf(A)
		hearers += get_clients_in_range(range_max,AT)
		if(!sound_source)
			sound_source = AT
	else
		CRASH_SAFE("Tried playing a sound without a valid ([location_or_list]) target!")
		return FALSE

	if(islist(sound_source))
		pos = sound_source
	else if(ismob(sound_source))
		var/mob/M = sound_source
		if(!M.client)
			log_error("Tried playing a sound to a mob ([M.get_debug_name()], but it had no client!")
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
	created_sound.status = 0
	created_sound.wait = 0
	created_sound.channel = SSsound.channel_hack
	SSsound.channel_hack++
	if(SSsound.channel_hack > 1024)
		SSsound.channel_hack = initial(SSsound.channel_hack)

	if(duration > 0)
		SSsound.active_sounds[created_sound] = duration
	else if(loop)
		SSsound.active_sounds[created_sound] = -1

	for(var/k in hearers)
		var/mob/M = k

		CHECK_TICK(SSsound.tick_usage_max,FPS_SERVER*2)

		if(!created_sound)
			log_error("WARNING: For some reason, [M] cannot hear the sound ([sound_path]) as it is deleted!")
			return FALSE

		if(!M.client || !M.client.eye) continue
		var/client/C = M.client

		var/turf/T = get_turf(M)
		if(!T) continue

		if(length(pos) && pos[3] != T.z) continue

		if(invisibility_check && M.see_invisible < invisibility_check) continue

		created_sound.environment = M.get_sound_environment()

		var/local_volume = volume
		if(length(pos))
			created_sound.x = pos[1] - T.x
			created_sound.z = pos[2] - T.y
			created_sound.y = 0
			if(channel != SOUND_CHANNEL_MUSIC && channel != SOUND_CHANNEL_AMBIENT)
				if(created_sound.x > range_max || created_sound.y > range_max)
					continue
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

	return created_sound
*/