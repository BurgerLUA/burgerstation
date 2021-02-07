/mob/living/advanced/player/pre_death()

	. = ..()

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
	if(mobdata)
		mobdata.save_character(src,save_inventory = FALSE,died = TRUE)

	return .

/mob/living/advanced/player/post_death()

	play_sound_target(pick('sound/ambient/death_1.ogg','sound/ambient/death_2.ogg','sound/ambient/death_3.ogg'),src,channel=SOUND_CHANNEL_MUSIC)

	var/list/people_who_contributed = list()
	var/list/people_who_killed = list()
	var/list/people_who_killed_names = list()

	for(var/k in attack_logs)
		var/list/attack_log = k
		if(attack_log["lethal"])
			var/mob/living/advanced/player/P = attack_log["attacker"]
			if(!(P in people_who_killed))
				people_who_killed += P
				people_who_killed_names += P.name

		if(!attack_log["lethal"] && attack_log["critical"])
			if(!(attack_log["attacker"] in people_who_contributed))
				people_who_contributed += attack_log["attacker"]

	if(!length(people_who_killed))
		people_who_killed = people_who_contributed

	var/date = get_date()
	var/time = get_time()

	if(prob(25) && last_words && length(people_who_killed) && people_who_killed[1] && people_who_killed[1] != src)
		var/obj/structure/interactive/soapstone_message/SM = SSsoapstone.create_new_soapstone(get_turf(src),SOUTH,"#000000",src.real_name,src.ckey,last_words,date,time)
		SM.invisibility = INVISIBLITY_GHOST

	/*
	if(ENABLE_KARMA)
		for(var/k in people_who_killed)
			var/mob/living/advanced/player/P = k

			if(!P.client || !P.mobdata) //Something something exploitable something something
				continue

			var/karma_gain = calculate_karma_gain_for_attacker(P,src)

			if(karma_gain > 0)
				karma_gain *= 1/length(people_who_killed)

			if(do_karma_event(P,src,karma_gain))
				punish_player(P)
	*/

	attack_logs = list()

	return ..()