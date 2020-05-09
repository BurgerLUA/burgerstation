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
		BLUNT = 0,
		PIERCE = 5,
		MAGIC = 25,
		HEAT = 10,
		COLD = 10,
		BIO = 25
	)

	size = SIZE_1
	weight = WEIGHT_0

	value = 20

	dyeable = TRUE

/obj/item/clothing/hands/gloves/colored/left
	name = "left white glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

/obj/item/clothing/hands/gloves/colored/black
	name = "right combat glove"
	color = "#404040"
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 25,
		BLUNT = 10,
		PIERCE = 25,
		LASER = -10,
		MAGIC = -25,
		HEAT = 25,
		COLD = 25,
		BOMB = 0,
		BIO = 10
	)

	protection_cold = list(
		BODY_HAND_RIGHT = 1
	)

	size = SIZE_1
	weight = WEIGHT_2

/obj/item/clothing/hands/gloves/colored/black/left
	name = "left combat glove"
	color = "#404040"
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
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 5,
		PIERCE = 5,
		LASER = 15,
		MAGIC = 25,
		HEAT = 75,
		COLD = 75,
		BIO = 10,
		FATIGUE = 100
	)

	protection_cold = list(
		BODY_HAND_LEFT = 2
	)

	size = SIZE_1
	weight = WEIGHT_1

	value = 60

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

	value = 40

/obj/item/clothing/hands/gloves/colored/padded
	name = "padded glove"
	icon = 'icons/obj/items/clothing/gloves/padded.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		HEAT = -10,
		COLD = 50
	)

	protection_cold = list(
		BODY_HAND_RIGHT = 3
	)

	size = SIZE_1
	weight = WEIGHT_1

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
	color = COLOR_BLACK

/obj/item/clothing/hands/gloves/colored/padded/black/left
	name = "left padded glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)



/obj/item/clothing/hands/gloves/colored/padded/brown
	color = COLOR_BROWN

/obj/item/clothing/hands/gloves/colored/padded/brown/left
	name = "left padded glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)