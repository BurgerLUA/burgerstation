/obj/item/clothing/hands/gloves/halo/spartan
	name = "MJOLNIR Mark V right Gauntlet"
	desc = "Heavy."
	desc_extended = "Hand armour, to be used with the MJOLNIR Mark V armor."
	icon = 'icons/obj/item/clothing/gloves/spartan.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	armor = /armor/military/light

	protection_cold = list(
		BODY_HAND_RIGHT = 3
	)

	size = SIZE_1

	value = 120
	flags_clothing = FLAG_CLOTHING_SPARTAN

/obj/item/clothing/hands/gloves/halo/spartan/left
	name = "MJOLNIR Mark V left Gauntlet"
	desc = "Heavy."
	desc_extended = "Hand armour, to be used with the MJOLNIR Mark V armor."

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)

