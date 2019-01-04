proc/time_prob(var/value)
	return prob(value / FPS_SERVER)


/proc/get_luck_calc(var/mob/positve_mob,var/positive_luck_mul,var/mob/negative_mob,var/negative_luck_mul)
	var/base_prob = 0

	if(positve_mob && positive_luck_mul)
		base_prob += (positve_mob.get_attribute_level(ATTRIBUTE_LUCK)-50)*positive_luck_mul

	if(negative_mob && negative_luck_mul)
		base_prob += (negative_mob.get_attribute_level(ATTRIBUTE_LUCK)-50)*negative_luck_mul

	return base_prob