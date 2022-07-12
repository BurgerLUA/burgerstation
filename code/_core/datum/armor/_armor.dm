// https://www.desmos.com/calculator/lor9o5vzic
var/global/list/defense_rating_to_value = list( //Lower values are more expensive.
	BLADE = 8.1,
	BLUNT = 8.1,
	PIERCE = 8.1,
	LASER = 8.1,
	ARCANE = 6,
	HEAT = 16.2,
	COLD = 16.2,
	SHOCK = 16.2,
	ACID = 16.2,
	BOMB = 16.2,
	BIO = 17.9,
	RAD = 16.2,
	HOLY = 6,
	DARK = 6,
	FATIGUE = 50,
	ION = 50,
	PAIN = 50
)


/armor/

	var/name

	var/list/defense_rating = list()

	var/list/damage_multipliers = list()

	var/deflection = 0 //0 to 1 value. 1 means highest chance to deflect and 0 means lowest chance. Also affects fatigue/stamina absorbtion (except blunt).

	var/value = 0 //Mainly used for clothing.

/armor/New(var/desired_loc)
	. = ..()
	value = 0
	var/total_armor = 0
	for(var/defense_type in defense_rating)
		if(defense_rating_to_value[defense_type])
			total_armor += clamp(defense_rating[defense_type],-300,300)/defense_rating_to_value[defense_type]
		if(defense_rating[defense_type] <= 0 || defense_rating_to_value[defense_type] <= 0)
			continue
		value += ((min(300,defense_rating[defense_type])**1.75)/defense_rating_to_value[defense_type])*0.5

	value *= 1 + (deflection*2)**1.5

	// https://www.desmos.com/calculator/o9ko6svfcg
	value *= 0.9 * ((total_armor+1000)*(1/1000))**2


