/obj/item/clothing/feet/shoes/black
	name = "right black shoe"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/items/clothing/shoes/black.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		MAGIC = ARMOR_C,
		HEAT = ARMOR_D,
		COLD = ARMOR_D
	)



/obj/item/clothing/feet/shoes/black/left
	name = "left black shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)