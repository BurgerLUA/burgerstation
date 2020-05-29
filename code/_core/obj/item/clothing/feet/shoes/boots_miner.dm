/obj/item/clothing/feet/shoes/miner
	name = "right mining boot"
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/items/clothing/shoes/boots_miner.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 15,
		PIERCE = 15,
		MAGIC = 10,
		HEAT = 25,
		COLD = 10,
	)

	size = SIZE_2
	weight = WEIGHT_2

	value = 50

	slowdown_mul_worn = 1.05

/obj/item/clothing/feet/shoes/miner/left
	name = "left mining boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT_U

