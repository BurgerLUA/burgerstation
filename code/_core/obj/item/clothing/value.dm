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
	BODY_HEAD = 1.3,
	BODY_TORSO = 1.3,
	BODY_GROIN = 1.2,
	BODY_ARM_LEFT = 1.15,
	BODY_ARM_RIGHT = 1.15,
	BODY_HAND_LEFT = 1.1,
	BODY_HAND_RIGHT = 10.1,
	BODY_LEG_LEFT = 1.15,
	BODY_LEG_RIGHT = 1.15,
	BODY_FOOT_LEFT = 1.1,
	BODY_FOOT_RIGHT = 1.1
)

/obj/item/clothing/get_base_value()

	. = 0

	for(var/defense_type in defense_rating)
		if(defense_rating[defense_type] <= 0 || defense_rating_to_value[defense_type] <= 0)
			continue
		. += (min(400,defense_rating[defense_type])**2)/defense_rating_to_value[defense_type]

	for(var/limb_zone in protected_limbs)
		if(limbs_to_value[limb_zone] <= 0)
			continue
		. *= limbs_to_value[limb_zone]

	// https://www.desmos.com/calculator/mzuyizloap
	if(is_container && dynamic_inventory_count > 0)
		. += ((dynamic_inventory_count*container_max_size)**1.4)*0.35

	. = CEILING(.,1)
