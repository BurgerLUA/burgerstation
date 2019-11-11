/atom/proc/play(var/sound_to_play,var/volume=100,var/pitch=1,var/loop=0,var/duration=0,var/pan=0,var/channel=SOUND_CHANNEL_FX,var/priority=0,var/echo=0,var/invisibility_check=0)

	var/environment = ENVIRONMENT_NONE

	var/area/A = get_area(src)

	if(A)
		environment = A.sound_environment

	play_sound(sound_to_play,all_mobs_with_clients,list(x,y,z),volume,pitch,loop,duration,pan,channel,priority,echo,environment,invisibility_check)