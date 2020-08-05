/obj/item/clothing/feet/shoes/miner
	name = "right mining boot"
	desc = "For when the heat is actually turned up."
	desc_extended = "A tough brown boot. Shields your feet from the ashes."
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/boots_miner.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 15,
		BLUNT = 25,
		PIERCE = 15,
		ARCANE = 25,
		HEAT = 25,
		COLD = 25,
		BOMB = 25
	)

	size = SIZE_2


	value = 80

	slowdown_mul_worn = 1.05

/obj/item/clothing/feet/shoes/miner/left
	name = "left mining boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT_U

