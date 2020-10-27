/obj/item/clothing/feet/shoes/tutorial
	name = "right tutorial boot"
	desc = "Cut content, perhaps?"
	desc_extended = "You probably shouldn't have this."
	rarity = RARITY_MYTHICAL
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/tutorial_shoes.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 15,
		BLUNT = 15,
		PIERCE = 15,
		LASER = -25,
		ARCANE = 25,
		COLD = 10
	)

	size = SIZE_2


	value = 100



/obj/item/clothing/feet/shoes/tutorial/left
	name = "left tutorial boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U

