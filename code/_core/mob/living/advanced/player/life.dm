/mob/living/advanced/player/pre_death()

	. = ..()

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
	if(mobdata)
		mobdata.save_character(src,save_inventory = FALSE,died = TRUE,force = TRUE)

/mob/living/advanced/player/post_death()

	if(suicide)
		attack_logs = list()

	play_sound_target(pick('sound/ambient/death_1.ogg','sound/ambient/death_2.ogg','sound/ambient/death_3.ogg'),src,channel=SOUND_CHANNEL_MUSIC)

	var/list/people_who_contributed = list()
	var/list/people_who_killed = list()
	var/list/people_who_killed_names = list()

	var/turf/T = get_turf(src)

	for(var/k in attack_logs)
		var/list/attack_log = k
		if(attack_log["lethal"])
			var/mob/living/advanced/player/P = attack_log["attacker"]
			people_who_killed |= P
			people_who_killed_names |= P.name
		if(!attack_log["lethal"] && attack_log["critical"])
			people_who_contributed |= attack_log["attacker"]

	if(!length(people_who_killed))
		people_who_killed = people_who_contributed

	if(length(people_who_killed))
		notify_ghosts("[src.name] was killed by [english_list(people_who_killed)]!",T)

	var/date = get_date()
	var/time = get_time()

	if(last_words && length(people_who_killed) && people_who_killed[1] && people_who_killed[1] != src)
		var/obj/structure/interactive/soapstone_message/SM = SSsoapstone.create_new_soapstone(T,SOUTH,"#000000",src.real_name,src.ckey,last_words,date,time)
		SM.invisibility = INVISIBLITY_GHOST

	for(var/k in people_who_killed)
		var/mob/living/advanced/player/P = k
		if(P != src) P.on_kill_player(src)

	attack_logs = list()

	return ..()

/mob/living/advanced/player/proc/on_kill_player(var/mob/living/advanced/player/P)


	return TRUE