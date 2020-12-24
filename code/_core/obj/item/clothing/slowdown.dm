//Values are percent. Example: A value of 0.01 means 0.01% slowdown per point.

var/global/list/armor_slowdown_values = list(
	BLADE = 0.02,
	BLUNT = 0.02,
	PIERCE = 0.02,
	LASER = 0.02,
	ARCANE = 0,
	HEAT = 0.01,
	COLD = 0.01,
	BOMB = 0.01,
	BIO = 0.01,
	RAD = 0.01,
	HOLY = 0.01,
	DARK = 0.01,
	FATIGUE = 0.02,
	ION = 0.02,
	PAIN = 0.02
)



/obj/item/clothing/proc/calculate_weight()

	var/init_weight = initial(weight)

	if(init_weight != 0)
		return init_weight

	. = 1

	for(var/k in defense_rating)
		if(IS_INFINITY(defense_rating[k]))
			continue
		. += defense_rating[k] * armor_slowdown_values[k]
	. *= length(protected_limbs)

	. = max(.,0)

	return .