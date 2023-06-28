

var/global/list/limbs_to_value = list(
	BODY_HEAD = 1.25,
	BODY_TORSO = 1,
	BODY_GROIN = 0.75,
	BODY_ARM_LEFT = 0.25,
	BODY_ARM_RIGHT = 0.25,
	BODY_HAND_LEFT = 0.125,
	BODY_HAND_RIGHT = 0.125,
	BODY_LEG_LEFT = 0.25,
	BODY_LEG_RIGHT = 0.25,
	BODY_FOOT_LEFT = 0.25,
	BODY_FOOT_RIGHT = 0.25
)

/obj/item/clothing/get_base_value()

	var/armor/A = ARMOR(armor)
	if(A) . = 5 + A.value

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

	if(speed_bonus > 0) // 3000 per 0.1 (10%)
		. += speed_bonus*(3000/0.1)

	. = CEILING(.,1)
