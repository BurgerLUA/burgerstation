/obj/item/clothing/feet/shoes/miner
	name = "right mining boot"
	desc = "For when the heat is actually turned up."
	desc_extended = "A tough brown boot. Shields your feet from the ashes."
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/boots_miner.dmi'

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		ARCANE = 20,
		HEAT = 20,
		COLD = 20,
		BOMB = 20,
		PAIN = 60
	)

	size = SIZE_2


	value = 80

/obj/item/clothing/feet/shoes/miner/left
	name = "left mining boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
