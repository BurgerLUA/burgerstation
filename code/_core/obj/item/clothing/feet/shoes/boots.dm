/obj/item/clothing/feet/shoes/black_boots
	name = "right black boot"
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/items/clothing/shoes/boots.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_D,
		LASER = ARMOR_E,
		MAGIC = -ARMOR_C,
		HEAT = ARMOR_E,
		COLD = ARMOR_C,
		BOMB = ARMOR_E
	)

	size = SIZE_2
	weight = WEIGHT_2

	value = 20

/obj/item/clothing/feet/shoes/black_boots/left
	name = "left black boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

