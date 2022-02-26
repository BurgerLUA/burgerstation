// https://www.desmos.com/calculator/lor9o5vzic
var/global/list/defense_rating_to_value = list(
	BLADE = 8.1,
	BLUNT = 8.1,
	PIERCE = 8.1,
	LASER = 8.1,
	ARCANE = 20,
	HEAT = 16.2,
	COLD = 16.2,
	SHOCK = 16.2,
	ACID = 16.2,
	BOMB = 16.2,
	BIO = 17.9,
	RAD = 16.2,
	HOLY = 20,
	DARK = 20,
	FATIGUE = 50,
	ION = 50,
	PAIN = 50
)


/armor/

	var/name

	var/list/defense_rating = list()

	var/list/damage_multipliers = list()

	var/value = 0 //Mainly used for clothing.

/armor/New(var/desired_loc)
	. = ..()
	value = 0
	for(var/defense_type in defense_rating)
		if(defense_rating[defense_type] <= 0 || defense_rating_to_value[defense_type] <= 0)
			continue
		value += ((min(400,defense_rating[defense_type])**1.75)/defense_rating_to_value[defense_type])*0.5