/obj/item/clothing/hands/gloves/colored
	name = "right white glove"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	desc = "Slap people with these."
	desc_extended = "A generic glove. Hope that you have a matching pair."
	icon = 'icons/obj/items/clothing/gloves/regular.dmi'
	color = "#FFFFFF"

	item_slot = SLOT_HAND_RIGHT
	protected_limbs = list(BODY_HAND_RIGHT)

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		LASER = 0,
		MAGIC = 15,
		HEAT = 0,
		COLD = 25,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

/obj/item/clothing/hands/gloves/colored/left
	name = "left white glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		LASER = 0,
		MAGIC = 15,
		HEAT = 0,
		COLD = 25,
		BOMB = 0,
		BIO = 25,
		RAD = 0,
		HOLY = -15,
		DARK = 15,
		FATIGUE = 0
	)

/obj/item/clothing/hands/gloves/colored/black
	name = "right combat glove"
	color = "#AAAAAA"

	defense_rating = list(
		BLADE = 15,
		BLUNT = 10,
		PIERCE = 5,
		LASER = 0,
		MAGIC = 5,
		HEAT = 5,
		COLD = 30,
		BOMB = 5,
		BIO = 0,
		RAD = 0,
		HOLY = 15,
		DARK = -15,
		FATIGUE = 0
	)

	protection_cold = list(
		BODY_HAND_RIGHT = 1
	)

/obj/item/clothing/hands/gloves/colored/black/left
	name = "left combat glove"
	color = "#AAAAAA"

	name = "left glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 1
	)


/obj/item/clothing/hands/gloves/colored/yellow
	name = "right insulted glove"
	color = "#FFFF00"

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		LASER = 25,
		MAGIC = 0,
		HEAT = 50,
		COLD = 25,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 25,
		FATIGUE = 50
	)

	protection_cold = list(
		BODY_HAND_LEFT = 2
	)

/obj/item/clothing/hands/gloves/colored/yellow/left
	name = "left insulted glove"
	color = "#FFFF00"

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_RIGHT = 2
	)

/obj/item/clothing/hands/gloves/colored/padded
	name = "padded glove"
	icon = 'icons/obj/items/clothing/gloves/padded.dmi'

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		LASER = 5,
		MAGIC = 0,
		HEAT = 10,
		COLD = 100,
		BOMB = 5,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	protection_cold = list(
		BODY_HAND_RIGHT = 3
	)

/obj/item/clothing/hands/gloves/colored/padded/left
	name = "left padded glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)

/obj/item/clothing/hands/gloves/colored/padded/black
	color = "#111111"

/obj/item/clothing/hands/gloves/colored/padded/black/left
	name = "left padded glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)
