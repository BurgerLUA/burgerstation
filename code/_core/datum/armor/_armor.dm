/armor/

	var/name

	var/list/defense_rating = list()

	var/list/damage_multipliers = list()

	var/deflection = 0 //0 to 1 value. 1 means highest chance to deflect and 0 means lowest chance. Also affects fatigue/stamina absorbtion (except blunt).

	var/value = 0 //Mainly used for clothing.

/armor/New(desired_loc)
	. = ..()
	value = 0
	var/total_armor = 0
	for(var/defense_type in defense_rating)
		if(SSbalance.defense_rating_to_value[defense_type] <= 0 || defense_rating[defense_type] <= 0)
			continue
		total_armor += min(defense_rating[defense_type],300)/SSbalance.defense_rating_to_value[defense_type]
		value += ((min(300,defense_rating[defense_type])**1.75)/SSbalance.defense_rating_to_value[defense_type])*0.5

	value *= 1 + (deflection*2)**1.5

	// https://www.desmos.com/calculator/o9ko6svfcg
	value *= 0.9 * ((total_armor+1000)*(1/1000))**2


