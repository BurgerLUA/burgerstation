/damagetype/proc/get_damage_per_hit()

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
		. += calculate_damage_with_armor(total_damages[k],max(0,100-attack_damage_penetration[k]))

	. *= damage_mod