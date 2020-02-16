/obj/item/clothing/feet/shoes/brown
	name = "right leather shoe"
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/items/clothing/shoes/brown.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D,
		MAGIC = ARMOR_D,
		HEAT = ARMOR_E,
		COLD = ARMOR_E
	)

	size = SIZE_1
	weight = WEIGHT_1

	value = 15

/obj/item/clothing/feet/shoes/brown/left
	name = "left leather shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)