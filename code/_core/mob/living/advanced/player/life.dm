/mob/living/advanced/player/pre_death()

	. = ..()

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
	if(mobdata)
		mobdata.save_character(src,save_inventory = FALSE,died = TRUE,force = TRUE)

/mob/living/advanced/player/on_killed(var/list/attackers)

	. = ..()

	play_sound_target(pick('sound/ambient/death_1.ogg','sound/ambient/death_2.ogg','sound/ambient/death_3.ogg'),src,channel=SOUND_CHANNEL_MUSIC)

	var/turf/T = get_turf(src)
	notify_ghosts("[src.name] was killed by [english_list(attackers)]!",T)

/mob/living/advanced/player/post_death()
	. = ..()
	if(ckey_last)
		dead_player_mobs |= src
		death_ckey = ckey_last

/mob/living/advanced/player/revive()
	. = ..()
	dead_player_mobs -= src
	death_ckey = null

/mob/living/advanced/player/proc/on_kill_player(var/mob/living/advanced/player/P)
	HOOK_CALL("on_kill_player")
	return TRUE