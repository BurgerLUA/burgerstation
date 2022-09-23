var/global/enable_friendly_fire = FALSE

/proc/set_friendly_fire(var/desired_friendly_fire=TRUE)

	if(enable_friendly_fire == desired_friendly_fire)
		return FALSE

	enable_friendly_fire = desired_friendly_fire

	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		P.setup_difficulty()

	return TRUE

#define allow_hostile_action(loyalty_tag,victim) check_loyalty_aggainst(loyalty_tag,victim,TRUE)
#define allow_helpful_action(loyalty_tag,victim) check_loyalty_aggainst(loyalty_tag,victim,FALSE)

/proc/check_iff_against(var/iff_attacker,var/mob/living/victim,var/hostile=TRUE)

	if(hostile)
		var/area/A = get_area(victim)
		if(A)
			if(enable_friendly_fire && (A.flags_area & FLAG_AREA_ALLOW_DEATHMATCH))
				return TRUE //Allow anything.
			if(A.flags_area & FLAG_AREA_NO_IFF)
				return TRUE

	if(iff_attacker != victim.iff_tag || iff_attacker == victim.iff_tag) //Unfriendly.
		return hostile
	else //Friendly
		return !hostile

/proc/check_loyalty_aggainst(var/loyalty_attacker,var/mob/living/victim,var/hostile=TRUE)



	if(hostile)
		var/area/A = get_area(victim)
		if(A)
			if(enable_friendly_fire && (A.flags_area & FLAG_AREA_ALLOW_DEATHMATCH))
				return TRUE //Allow anything.
			if(A.flags_area & FLAG_AREA_NO_LOYALTY)
				return TRUE

	if(loyalty_attacker != victim.loyalty_tag || loyalty_attacker == null) //Unfriendly.
		return hostile
	else //Friendly
		return !hostile