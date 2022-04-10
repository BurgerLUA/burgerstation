var/global/enable_friendly_fire = FALSE

/proc/set_friendly_fire(var/desired_friendly_fire=TRUE)

	if(enable_friendly_fire == desired_friendly_fire)
		return FALSE

	enable_friendly_fire = desired_friendly_fire

	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		P.setup_difficulty()

	return TRUE

/proc/check_iff(var/iff_tag_1,var/iff_tag_2,var/area/A,var/hostile=TRUE) //Returns true if the tags are allowed to attack eachother.

	if(A && hostile && enable_friendly_fire && (A.area_identifier & (FLAG_AREA_ALLOW_DEATHMATCH|FLAG_AREA_NO_IFF)))
		return TRUE //Allow anything.

	if(iff_tag_1 != iff_tag_2 || iff_tag_1 == null) //Unfriendly.
		return hostile
	else //Friendly
		return !hostile

/proc/check_loyalty(var/loyalty_tag_1,var/loyalty_tag_2,var/area/A,var/hostile=TRUE) //Returns true if the tags are allowed to attack eachother.

	if(A && hostile && enable_friendly_fire && (A.area_identifier & (FLAG_AREA_ALLOW_DEATHMATCH|FLAG_AREA_NO_LOYALTY)))
		return TRUE //Allow anything.

	if(loyalty_tag_1 != loyalty_tag_2 || loyalty_tag_1 == null) //Unfriendly.
		return hostile
	else //Friendly
		return !hostile


#define allow_hostile_action(loyalty_tag_1,loyalty_tag_2,A) check_loyalty(loyalty_tag_1,loyalty_tag_2,A,TRUE)
#define allow_helpful_action(loyalty_tag_1,loyalty_tag_2) check_loyalty(loyalty_tag_1,loyalty_tag_2,null,FALSE)