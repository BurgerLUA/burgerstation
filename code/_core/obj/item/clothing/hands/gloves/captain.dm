/obj/item/clothing/hands/gloves/captain
	name = "right Captain's glove"
	icon = 'icons/obj/items/clothing/gloves/captain.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	item_slot = SLOT_HAND_RIGHT
	protected_limbs = list(BODY_HAND_RIGHT)

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 50,
		MAGIC = -100,
		HEAT = 100,
		COLD = 100,
		BOMB = 25,
		BIO = 75,
		RAD = 75,
		FATIGUE = 100
	)

	protection_cold = list(
		BODY_HAND_RIGHT = 1
	)

	size = SIZE_1
	weight = WEIGHT_3

	value = 500

/obj/item/clothing/hands/gloves/captain/left
	name = "left Captain's glove"

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 1
	)