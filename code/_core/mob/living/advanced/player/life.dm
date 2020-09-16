/mob/living/advanced/player/pre_death()

	. = ..()

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
	if(mobdata)
		mobdata.save_character(src,save_inventory = FALSE,died = TRUE)

	return .

/mob/living/advanced/player/post_death()

	play(pick('sound/ambient/death_1.ogg','sound/ambient/death_2.ogg','sound/ambient/death_3.ogg'),src)

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

	/*
	var/date = get_date()
	var/time = get_time()


	if(last_words && length(people_who_killed) && people_who_killed[1] && people_who_killed[1] != src)
		SSsoapstone.create_new_soapstone(get_turf(src),SOUTH,"#000000",src.real_name,src.ckey,last_words,date,time)
	*/

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

	CALLBACK("beef_create_\ref[src]",SECONDS_TO_DECISECONDS(rand(BEEF_TIME_SECONDS,BEEF_TIME_SECONDS*1.2)),src,.proc/create_beef)

	return ..()


/mob/living/advanced/player/revive()
	. = ..()
	if(.)
		CALLBACK_REMOVE("beef_create_\ref[src]")
	return .

/mob/living/advanced/player/proc/create_beef()

	if(qdeleting)
		return FALSE

	var/area/A = get_area(src)
	if(A.flags_area & FLAGS_AREA_NO_DAMAGE)
		return FALSE

	for(var/mob/living/advanced/player/P in viewers(VIEW_RANGE))
		if(!P.dead)
			return FALSE

	for(var/i=1,i<=rand(1,3),i++)
		var/mob/living/advanced/npc/beefman/B = new(src.loc)
		INITIALIZE(B)
		GENERATE(B)
		FINALIZE(B)
		step_rand(B)

	return TRUE
