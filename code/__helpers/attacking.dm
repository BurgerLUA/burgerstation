/*
proc/calculate_damage_with_armor(var/damage,var/armor)
	armor = clamp(armor,0,ARMOR_CAP)
	var/returning = (damage - armor*(20/ARMOR_CAP))*(1 - clamp(armor/ARMOR_CAP,0,0.75))
	return CEILING(returning, 1)
*/
