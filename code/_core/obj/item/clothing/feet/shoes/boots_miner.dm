/obj/item/clothing/feet/shoes/boots_miner
	name = "right mining boot"
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/items/clothing/shoes/boots_miner.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_C,
		HEAT = ARMOR_C
	)

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/clothing/feet/shoes/boots_miner/left
	name = "left mining boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

