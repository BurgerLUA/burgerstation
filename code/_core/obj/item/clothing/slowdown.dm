//Values are percent. Example: A value of 0.01 means 0.01% slowdown per point.

var/global/list/armor_slowdown_values = list(
	BLADE = 0.02,
	BLUNT = 0.02,
	PIERCE = 0.02,
	LASER = 0.02,
	MAGIC = 0.01,
	HEAT = 0.01,
	COLD = 0.01,
	BOMB = 0.01,
	BIO = 0.01,
	RAD = 0.03,
	HOLY = 0.01,
	DARK = 0.01,
	FATIGUE = 0.02,
	ION = 0.02
)



/obj/item/clothing/proc/calculate_slowdown()

	. = 0

	for(var/k in defense_rating)
		. += defense_rating[k] * armor_slowdown_values[k]

	. *= length(protected_limbs)

	slowdown_mul_held = FLOOR(1 + .*0.25*0.01,0.1)
	slowdown_mul_worn = FLOOR(1 + .*0.01,0.1)

	return .