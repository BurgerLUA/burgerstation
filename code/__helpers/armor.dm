proc/calculate_armor(var/damage_dealt,var/armor_rating)

	//TODO: Move these to defines

	var/multiplier = 0.003
	var/subtract = 0.1

	var/min_subtract = 0.25
	var/min_multiplier = 0.5

	var/min_total_damage = 0.25

	var/sub_part = damage_dealt - min(damage_dealt*min_subtract,subtract*armor_rating)
	var/mul_part = max(min_multiplier,1-(armor_rating*multiplier))

	return max(damage_dealt*min_total_damage,sub_part*mul_part)