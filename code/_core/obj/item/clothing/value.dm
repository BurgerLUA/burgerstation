https://www.desmos.com/calculator/lor9o5vzic

var/global/list/defense_rating_to_value = list(
	BLADE = 8.1,
	BLUNT = 8.1,
	PIERCE = 8.1,
	LASER = 8.1,
	MAGIC = 10.1,
	HEAT = 11.6,
	COLD = 11.6,
	BOMB = 16.2,
	BIO = 17.9,
	RAD = 16.2,
	HOLY = 10.1,
	DARK = 10.1,
	FATIGUE = 27,
	ION = 27,
	PAIN = 27
)

var/global/list/limbs_to_value = list(
	BODY_HEAD = 0.3,
	BODY_TORSO = 0.3,
	BODY_GROIN = 0.2,
	BODY_ARM_LEFT = 0.15,
	BODY_ARM_RIGHT = 0.15,
	BODY_HAND_LEFT = 0.1,
	BODY_HAND_RIGHT = 0.1,
	BODY_LEG_LEFT = 0.15,
	BODY_LEG_RIGHT = 0.15,
	BODY_FOOT_LEFT = 0.1,
	BODY_FOOT_RIGHT = 0.1
)

/obj/item/clothing/proc/generate_value()

	value = 0

	for(var/defense_type in defense_rating)
		var/defense_value = defense_rating[defense_type]
		if(!defense_value || defense_value < 0)
			continue
		if(IS_INFINITY(defense_value))
			value += 500
			continue

		value += (defense_value**2)/defense_rating_to_value[defense_type]

	var/base_multiplier = 0

	for(var/limb_zone in protected_limbs)
		var/limb_zone_value = limbs_to_value[limb_zone]
		base_multiplier += limb_zone_value

	value = CEILING(max(value*base_multiplier,10),1)

	return TRUE