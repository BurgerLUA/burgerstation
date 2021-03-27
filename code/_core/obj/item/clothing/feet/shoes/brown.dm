/obj/item/clothing/feet/shoes/brown
	name = "right leather shoe"
	desc = "Protects your feet from cigarettes."
	desc_extended = "An expensive brown shoe, fit for a detective."
	rarity = RARITY_UNCOMMON
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/item/clothing/shoes/brown.dmi'

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		ARCANE = AP_SWORD,
		COLD = AP_SWORD,
		PAIN = AP_SWORD
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