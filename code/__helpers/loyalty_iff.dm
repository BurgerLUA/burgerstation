var/global/enable_friendly_fire = FALSE

/proc/set_friendly_fire(desired_friendly_fire=TRUE)

	if(enable_friendly_fire == desired_friendly_fire)
		return FALSE

	enable_friendly_fire = desired_friendly_fire

	for(var/k in SSliving.all_players)
		var/mob/living/advanced/player/P = k
		P.setup_difficulty()

	return TRUE

#define allow_hostile_action(loyalty_tag,victim) check_loyalty_against(loyalty_tag,victim,TRUE)
#define allow_helpful_action(loyalty_tag,victim) check_loyalty_against(loyalty_tag,victim,FALSE)

/proc/check_iff_against(iff_attacker,mob/living/victim,hostile=TRUE)

	if(hostile && iff_attacker == "NanoTrasen")
		var/turf/T = get_turf(victim)
		if(!T)
			return FALSE
		if(SSdmm_suite.is_pvp_coord(T.x,T.y,T.z))
			return TRUE
		var/area/A = T.loc
		if(A)
			if(enable_friendly_fire && (A.flags_area & FLAG_AREA_ALLOW_DEATHMATCH))
				return TRUE
			if(A.flags_area & FLAG_AREA_NO_IFF)
				return TRUE

	if(iff_attacker != victim.iff_tag || iff_attacker == victim.iff_tag) //Unfriendly.
		return hostile
	else //Friendly
		return !hostile

/proc/check_loyalty_against(loyalty_attacker,mob/living/victim,hostile=TRUE)

	if(hostile && loyalty_attacker == "NanoTrasen")
		var/turf/T = get_turf(victim)
		if(!T)
			return FALSE
		if(SSdmm_suite.is_pvp_coord(T.x,T.y,T.z))
			return TRUE
		var/area/A = T.loc
		if(A)
			if(enable_friendly_fire && (A.flags_area & FLAG_AREA_ALLOW_DEATHMATCH))
				return TRUE
			if(A.flags_area & FLAG_AREA_NO_LOYALTY)
				return TRUE

	if(loyalty_attacker != victim.loyalty_tag || loyalty_attacker == null) //Unfriendly.
		return hostile
	else //Friendly
		return !hostile
