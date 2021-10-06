// https://www.desmos.com/calculator/lor9o5vzic

var/global/list/defense_rating_to_value = list(
	BLADE = 8.1,
	BLUNT = 8.1,
	PIERCE = 8.1,
	LASER = 8.1,
	ARCANE = 20,
	HEAT = 16.2,
	COLD = 16.2,
	BOMB = 16.2,
	BIO = 17.9,
	RAD = 16.2,
	HOLY = 20,
	DARK = 20,
	FATIGUE = 50,
	ION = 50,
	PAIN = 50
)

var/global/list/limbs_to_value = list(
	BODY_HEAD = 1,
	BODY_TORSO = 1,
	BODY_GROIN = 0.75,
	BODY_ARM_LEFT = 0.5,
	BODY_ARM_RIGHT = 0.5,
	BODY_HAND_LEFT = 0.25,
	BODY_HAND_RIGHT = 0.25,
	BODY_LEG_LEFT = 0.5,
	BODY_LEG_RIGHT = 0.5,
	BODY_FOOT_LEFT = 0.25,
	BODY_FOOT_RIGHT = 0.25
)

/obj/item/clothing/get_base_value()

	. = 0

	for(var/defense_type in defense_rating)
		if(defense_rating[defense_type] <= 0 || defense_rating_to_value[defense_type] <= 0)
			continue
		. += ((min(400,defense_rating[defense_type])**1.75)/defense_rating_to_value[defense_type])*0.5

	var/total_value_mul = 0
	for(var/limb_zone in protected_limbs)
		if(limbs_to_value[limb_zone] <= 0)
			continue
		total_value_mul += limbs_to_value[limb_zone]
	if(total_value_mul > 0)
		. *= total_value_mul

	// https://www.desmos.com/calculator/mzuyizloap
	if(is_container && dynamic_inventory_count > 0)
		. += ((dynamic_inventory_count*container_max_size)**1.4)*0.35

	. = CEILING(.,1)
