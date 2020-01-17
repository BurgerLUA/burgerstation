/obj/item/clothing/feet/shoes/engineering
	name = "right engineering boot"
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/items/clothing/shoes/engineering_rig_boots.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_D,
		LASER = ARMOR_E,
		MAGIC = -ARMOR_C,
		HEAT = ARMOR_B,
		COLD = ARMOR_B,
		BOMB = ARMOR_E,
		BIO = ARMOR_D,
		RAD = ARMOR_B
	)

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/clothing/feet/shoes/engineering/left
	name = "left engineering boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

