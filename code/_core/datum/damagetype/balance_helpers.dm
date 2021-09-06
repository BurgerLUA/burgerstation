/damagetype/proc/get_damage_per_hit(var/armor_to_use=0)

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

	for(var/k in total_damages)
		var/armor_calc = attack_damage_penetration[k]*penetration_mod
		if(armor_calc < 0 && armor_to_use <= 0)
			armor_calc = 0
		armor_calc = max(min(armor_to_use,0),armor_to_use-armor_calc)
		. += calculate_damage_with_armor(total_damages[k],armor_calc)

	. *= damage_mod