var/global/list/active_sounds = list()

/datum/subsystem/sound/
	name = "Sound Subsystem"
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_SOUND

/datum/subsystem/sound/on_life()
	for(var/F in active_sounds)
		var/sound/S = F
		active_sounds[S] -= 1
		if(active_sounds[S] <= 0)
			S.status = SOUND_MUTE | SOUND_UPDATE
			for(var/mob/M in all_mobs)
				M << S
			active_sounds -= S
			S = null
			del(S)
			continue

	return TRUE

proc/play_sound(var/sound_path, var/list/atom/hearers = list(), var/list/pos = list(0,0,0), var/volume=100, var/pitch=1, var/loop=0, var/duration=0, var/pan=0, var/channel=0, var/priority=0, var/echo = 0, var/environment = ENVIRONMENT_GENERIC)
	var/sound/created_sound = sound(sound_path)

	//created_sound.volume = volume
	created_sound.frequency = pitch
	created_sound.repeat = loop
	created_sound.pan = pan
	created_sound.channel = channel
	created_sound.priority = priority
	created_sound.echo = echo
	created_sound.environment = environment

	if(duration)
		active_sounds[created_sound] = duration

	for(var/atom/H in hearers)
		var/local_volume = volume

		created_sound.x = pos[1] - H.x
		created_sound.y = pos[2] - H.y
		created_sound.z = pos[3] - H.z

		if(created_sound.z != 0)
			continue

		var/distance = sqrt(created_sound.x**2 + created_sound.y**2)
		local_volume = max(local_volume - distance*2,0)

		if(volume <= 0)
			continue

		if(istype(H,/mob/))
			var/mob/M = H
			if(M.client)
				var/zoom_level = M.client.zoom_level
				var/zoom_volume = clamp( (log(zoom_level)*0.5) - 1.77,0.05,1)
				created_sound.volume = local_volume * zoom_volume
		H << created_sound

	created_sound.status = SOUND_UPDATE

	return created_sound
