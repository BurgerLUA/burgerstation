/obj/item/clothing/hands/gloves/engineering
	name = "right engineering glove"
	desc = "Spacewalk with theese."
	desc_extended = "Part of the engineering rigsuit. Don't lose them!"
	icon = 'icons/obj/item/clothing/gloves/engineering_rig_gloves.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	item_slot = SLOT_HAND_RIGHT
	protected_limbs = list(BODY_HAND_RIGHT)

	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 25,
		LASER = 25,
		ARCANE = -75,
		HEAT = 100,
		COLD = 100,
		BOMB = 25,
		BIO = 50,
		RAD = 75,
		FATIGUE = INFINITY
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

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)
	blocks_clothing = SLOT_HAND_LEFT

	protection_cold = list(
		BODY_HAND_LEFT = 2
	)