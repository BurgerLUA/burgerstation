/obj/item/clothing/feet/shoes/tutorial
	name = "right tutorial boot"
	desc = "Cut content, perhaps?"
	desc_extended = "You probably shouldn't have this."
	rarity = RARITY_MYTHICAL
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/tutorial_shoes.dmi'

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = -AP_AXE,
		ARCANE = AP_AXE,
		COLD = AP_AXE
	)

	size = SIZE_2


	value = 100



/obj/item/clothing/feet/shoes/tutorial/left
	name = "left tutorial boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

