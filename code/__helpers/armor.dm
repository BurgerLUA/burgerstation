//https://www.desmos.com/calculator/0d3mebhto4

/proc/calculate_damage_with_armor(var/damage_dealt,var/armor_rating)
	if(armor_rating == INFINITY)
		return 0
	return CEILING(max(damage_dealt*0.25,(damage_dealt - (armor_rating*0.4)) * max(0.5,1 - (armor_rating/(50+damage_dealt)))), 1)