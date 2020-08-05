/obj/item/clothing/feet/shoes/brown
	name = "right leather shoe"
	desc = "Protects your feet from cigarettes."
	desc_extended = "An expensive brown shoe, fit for a detective."
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/item/clothing/shoes/brown.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = 15,
		BLUNT = 10,
		PIERCE = 10,
		ARCANE = 25,
		COLD = 10
	)

	size = SIZE_1


	value = 15

/obj/item/clothing/feet/shoes/brown/left
	name = "left leather shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT_U