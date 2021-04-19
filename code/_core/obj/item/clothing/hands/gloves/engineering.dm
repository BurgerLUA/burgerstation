/obj/item/clothing/hands/gloves/engineering
	name = "right engineering glove"
	desc = "Spacewalk with theese."
	desc_extended = "Part of the engineering rigsuit. Don't lose them!"
	icon = 'icons/obj/item/clothing/gloves/engineering_rig_gloves.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		ARCANE = -AP_GREATCLUB,
		HEAT = AP_GREATSWORD,
		COLD = AP_GREATSWORD,
		BOMB = 40,
		BIO = 20,
		RAD = AP_GREATSWORD,
		FATIGUE = INFINITY,
		PAIN = AP_GREATSWORD
	)

	protection_cold = list(
		BODY_HAND_RIGHT = 2
	)

	size = SIZE_1

	value = 230

/obj/item/clothing/hands/gloves/engineering/left
	name = "left engineering glove"
	desc = "Spacewalk with theese."
	desc_extended = "Part of the engineering rigsuit. Don't lose them!"

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 2
	)