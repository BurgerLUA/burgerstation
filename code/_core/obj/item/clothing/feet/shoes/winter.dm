/obj/item/clothing/feet/shoes/winter
	name = "right winter boot"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/items/clothing/shoes/winter.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_E,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E,
		LASER = -ARMOR_D,
		MAGIC = -ARMOR_D,
		HEAT = -ARMOR_C,
		COLD = ARMOR_A
	)

	protection_cold = list(
		BODY_FOOT_RIGHT = 3,
		BODY_LEG_RIGHT = 1
	)

	size = SIZE_2
	weight = WEIGHT_3

	value = 30

/obj/item/clothing/feet/shoes/winter/left
	name = "left winter boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

	protection_cold = list(
		BODY_FOOT_LEFT = 3,
		BODY_LEG_LEFT = 1
	)
