/damagetype/proc/get_damage_per_hit(var/armor_to_use=0,var/self_armor_to_use=0)

	if(IS_INFINITY(armor_to_use))
		return 0

	var/list/total_damages = list()

	for(var/k in attack_damage_base)
		if(!total_damages[k])
			total_damages[k] = 0
		total_damages[k] += attack_damage_base[k]

	for(var/k in skill_stats)
		if(!total_damages[k])
			total_damages[k] = 0
		total_damages[k] += skill_stats[k]

	for(var/k in attribute_stats)
		if(!total_damages[k])
			total_damages[k] = 0
		total_damages[k] += attribute_stats[k]

	. = 0

	for(var/damage_type in total_damages)
		var/damage = total_damages[damage_type]
		var/penetration = attack_damage_penetration[damage_type]
		var/final_armor_to_use = armor_to_use
		if(IS_INFINITY(penetration))
			final_armor_to_use = 0
		else
			penetration *= penetration_mod
			if(penetration < 0) //Negative penetration means add armor.
				if(final_armor_to_use > 0) //Target has armor.
					final_armor_to_use -= penetration //Add the extra armor.
			else //Positive penetration means subtract armor.
				if(final_armor_to_use > 0) //Target has armor.
					final_armor_to_use = max(0,final_armor_to_use - penetration)
				//Negative armor means a damage multiplier (handled in calculate_damage_with_armor)
		if(!ignore_armor_bonus_damage && (damage_type == ARCANE || damage_type == HOLY || damage_type == DARK)) //Deal bonus damage.
			damage *= clamp(1 + self_armor_to_use*0.01,0,2)
		. += calculate_damage_with_armor(damage*damage_mod,final_armor_to_use)

