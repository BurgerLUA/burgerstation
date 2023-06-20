#define ROUND_END_DIRECTORY "sound/round_end/"

SUBSYSTEM_DEF(sound)
	name = "Sound Subsystem"
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_FIRST
	var/channel_hack = 100

	tick_usage_max = 90

	var/list/round_end_sounds = list()

	var/list/active_sounds = list()

	var/list/sound_cache = list()

/subsystem/sound/unclog(var/mob/caller)
	for(var/k in active_sounds)
		var/sound/S = k
		active_sounds -= k
		if(!S || S.qdeleting)
			continue
		qdel(S)
	. = ..()

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
		var/sound/S = F
		if(!S || S.qdeleting)
			continue
		if(!process_sound(S))
			log_error("Warning! Could not properly process an active sound!")
			active_sounds -= F
		CHECK_TICK(tick_usage_max,FPS_SERVER)

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

proc/play_music_track(var/music_track_id,var/client/hearer,var/volume=35,var/looping=FALSE)

	stop_music_track(hearer)

	var/track/T = SStrack.all_tracks[music_track_id]
	if(!T) CRASH("WARNING: INVALID MUSIC TRACK: [music_track_id].")

	var/volume_mod = 50

	if(hearer.settings && hearer.settings.loaded_data)
		volume_mod = hearer.settings.loaded_data["volume_music"]

	var/sound/created_sound = sound(T.path)

	if(!created_sound)
		log_error("Warning! Invalid sound: [T.path].")
		return FALSE

	created_sound.channel = SOUND_CHANNEL_MUSIC
	created_sound.priority = 0
	created_sound.status = 0
	created_sound.volume = volume * (volume_mod/100)
	created_sound.status = SOUND_STREAM
	created_sound.repeat = looping

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

/proc/get_clients_in_range(var/range,var/atom/epicenter=usr)

	. = list()
	for(var/k in all_mobs_with_clients)
		var/mob/M = k
		if(get_dist(epicenter,M) > range)
			continue
		. += M

/proc/setup_sound(var/sound_path)

	if(!SSsound || !SSsound.initialized)
		return FALSE

	var/sound/created_sound

	if(SSsound.sound_cache[sound_path])
		created_sound = SSsound.sound_cache[sound_path]
	else
		created_sound = sound(sound_path)
		if(!created_sound) CRASH("Invalid sound! [sound_path].")

		SSsound.sound_cache[sound_path] = created_sound

	return created_sound


/proc/play_sound_target(var/sound_path,var/mob/M,var/range_min=SOUND_RANGE*0.25, var/range_max = SOUND_RANGE, var/volume=50, var/sound_setting = SOUND_SETTING_FX, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/invisibility_check = 0,var/tracked)

	if(!M)
		CRASH("Error: Tried playing sound '[sound_path]' without a mob target!")

	if(!is_mob(M))
		if(is_datum(M))
			CRASH("Error: Tried playing sound '[sound_path]' to [M.get_debug_name()], a non-mob!")
		else
			CRASH("Error: Tried playing sound '[sound_path]' to with the mob arg to '[M]'!")

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
		log_error("WARNING: For some reason, [M] cannot hear the sound ([sound_path]) as the sound is deleted!")
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

	created_sound.volume = local_volume

	C << created_sound

	return C

/proc/play_sound_global(var/sound_path,var/list/hearers=all_mobs_with_clients, var/volume=50, var/sound_setting = SOUND_SETTING_FX, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/invisibility_check = 0,var/tracked)

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

		if(channel == SOUND_CHANNEL_AMBIENT || channel == SOUND_CHANNEL_FOOTSTEPS || channel == SOUND_CHANNEL_FX)
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



/proc/play_sound(var/sound_path,var/turf/source_turf,var/list/hearers,var/range_min=1, var/range_max = SOUND_RANGE, var/volume=50, var/sound_setting = SOUND_SETTING_FX, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=SOUND_CHANNEL_FX, var/priority=0, var/echo = 0, var/invisibility_check = 0,var/tracked)

	if(volume <= 0 || range_max <= 0)
		return FALSE

	if(!source_turf)
		CRASH("Error: Tried playing sound '[sound_path]' without a source_turf target!")

	if(!is_turf(source_turf))
		if(is_datum(source_turf))
			CRASH("Error: Tried playing sound '[sound_path]' to [source_turf.get_debug_name()], a non-turf!")
		else
			CRASH("Error: Tried playing sound '[sound_path]' to with the source_turf arg to '[source_turf]'!")

	var/sound/created_sound = setup_sound(sound_path)
	if(!created_sound)
		return FALSE
	if(!source_turf)
		log_error("Warning: play_sound passed source_turf as null for sound [sound_path]!")
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

		var/local_volume = M.get_sound_volume(volume,channel)
		if(local_volume <= 0)
			continue

		var/turf/mob_turf = get_turf(M)
		if(!mob_turf)
			continue

		if(channel != SOUND_CHANNEL_MUSIC && channel != SOUND_CHANNEL_AMBIENT)
			var/distance = max(0,get_dist(mob_turf,source_turf)-(VIEW_RANGE*0.5)) - range_min
			if(sound_setting == SOUND_SETTING_FOOTSTEPS && distance <= 0)
				distance = 4
			local_volume = (local_volume - distance*0.25)*max(0,range_max - distance)/range_max
			if(local_volume <= 0)
				continue

		created_sound.volume = local_volume
		if(channel == SOUND_CHANNEL_AMBIENT || channel == SOUND_CHANNEL_FOOTSTEPS || channel == SOUND_CHANNEL_FX)
			created_sound.environment = M.get_sound_environment()
			created_sound.x = source_turf.x - mob_turf.x
			created_sound.z = source_turf.y - mob_turf.y
			created_sound.y = 0

		if(tracked)
			if(M.client.tracked_sounds[tracked])
				var/sound/S = sound()
				S.channel = M.client.tracked_sounds[tracked]
				M << S
			M.client.tracked_sounds[tracked] = created_sound.channel
			var/track_length = length(M.client.tracked_sounds)
			if(track_length > 50)
				M.client.tracked_sounds.Cut(1,track_length - 50)

		M << created_sound

	return created_sound