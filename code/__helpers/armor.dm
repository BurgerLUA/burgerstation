/proc/calculate_damage_with_armor(var/damage_dealt,var/armor_rating)
	if(armor_rating == INFINITY)
		return 0
	return CEILING(max(1,(damage_dealt - armor_rating*0.1) * max(0.25,1 - armor_rating/(100+damage_dealt))), 1)