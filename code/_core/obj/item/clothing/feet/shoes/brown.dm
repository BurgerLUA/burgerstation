/obj/item/clothing/feet/shoes/brown
	name = "right leather shoe"
	desc = "Protects your feet from cigarettes."
	desc_extended = "An expensive brown shoe, fit for a detective."
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/item/clothing/shoes/brown.dmi'

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		ARCANE = 20,
		COLD = 20,
		PAIN = 20
	)

	size = SIZE_1


	value = 15

/obj/item/clothing/feet/shoes/brown/left
	name = "left leather shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)