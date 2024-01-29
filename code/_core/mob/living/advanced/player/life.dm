/mob/living/advanced/player/pre_death()

	. = ..()

	if(.)
		var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
		if(mobdata)
			if(world_state == STATE_RUNNING)
				mobdata.save_character(src,died = TRUE)
			else
				mobdata.save_character(src)
				allow_save = FALSE //So deathboxes don't save.

/mob/living/advanced/player/on_killed(list/attackers)

	. = ..()

	if(. && ckey_last)
		play_sound_target(pick('sound/ambient/death_1.ogg','sound/ambient/death_2.ogg','sound/ambient/death_3.ogg'),src,channel=SOUND_CHANNEL_MUSIC)
		var/turf/T = get_turf(src)
		notify_ghosts("[src.name] was killed by [english_list(attackers)]!",T)

/mob/living/advanced/player/post_death()
	. = ..()
	if(. && ckey_last)
		SSliving.dead_player_mobs += src
		death_ckey = ckey_last

/mob/living/advanced/player/revive()
	. = ..()
	if(.)
		SSliving.dead_player_mobs -= src
		death_ckey = null


/mob/living/advanced/player/proc/on_kill_player(mob/living/advanced/player/P)
	HOOK_CALL("on_kill_player")
	return TRUE


/mob/living/advanced/player/on_life_client()
	. = ..()
	if(spam_protection_command > 0) spam_protection_command = max(0,spam_protection_command-TICKS_TO_SECONDS(1))