
var/global/enable_friendly_fire = FALSE


/proc/check_iff(var/iff_tag_1,var/iff_tag_2,var/area/A,var/hostile=TRUE) //Returns true if the tags are allowed to attack eachother.

	if(A && hostile && enable_friendly_fire)
		if(A.area_identifier & (FLAG_AREA_ALLOW_DEATHMATCH|FLAG_AREA_NO_IFF))
			return TRUE

	if(iff_tag_1 != iff_tag_2 || iff_tag_1 == null || iff_tag_2 == null) //Unfriendly.
		return hostile
	else
		return !hostile

/proc/check_loyalty(var/loyalty_tag_1,var/loyalty_tag_2,var/area/A,var/hostile=TRUE) //Returns true if the tags are allowed to attack eachother.

	if(A && hostile && enable_friendly_fire)
		if(A.area_identifier & (FLAG_AREA_ALLOW_DEATHMATCH|FLAG_AREA_NO_LOYALTY))
			return TRUE

	if(loyalty_tag_1 != loyalty_tag_2 || loyalty_tag_1 == null || loyalty_tag_2 == null) //Unfriendly.
		return hostile
	else
		return !hostile