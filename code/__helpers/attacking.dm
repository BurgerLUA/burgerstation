proc/calculate_damage_with_armor(var/damage,var/armor)
	armor = Clamp(armor,0,ARMOR_CAP)
	return (damage - armor*(20/ARMOR_CAP))*(1 - Clamp(armor/ARMOR_CAP,0,0.75))
