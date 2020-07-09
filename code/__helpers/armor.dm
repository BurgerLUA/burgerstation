//https://www.desmos.com/calculator/0d3mebhto4

/proc/calculate_damage_with_armor(var/damage_dealt,var/armor_rating)
	if(damage_dealt < 0)
		CRASH_SAFE("[damage_dealt] was negative!")
		return 0
	if(!damage_dealt || !armor_rating)
		return damage_dealt
	if(abs(armor_rating) == INFINITY)
		return 0
	if(armor_rating <= 0)
		return damage_dealt * (1 + (-armor_rating/100))
	return clamp((damage_dealt - (armor_rating*0.4)) * max(0.5,1 - (armor_rating/(50+damage_dealt))),damage_dealt*0.25,damage_dealt)