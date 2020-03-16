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
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		MAGIC = ARMOR_C,
		HEAT = ARMOR_D,
		COLD = ARMOR_C,
		BIO = ARMOR_D
	)

	size = SIZE_1
	weight = WEIGHT_0

	value = 20

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
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_C,
		MAGIC = -ARMOR_D,
		HEAT = ARMOR_E,
		COLD = ARMOR_D,
		BIO = ARMOR_E
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
		BLADE = ARMOR_E,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E,
		MAGIC = ARMOR_A,
		HEAT = ARMOR_A,
		COLD = ARMOR_A,
		BIO = ARMOR_E,
		FATIGUE = ARMOR_A
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
		BLADE = ARMOR_E,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E,
		LASER = ARMOR_E,
		MAGIC = -ARMOR_E,
		HEAT = -ARMOR_D,
		COLD = ARMOR_S,
		BOMB = ARMOR_D,
		FATIGUE = ARMOR_D
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
	color = "#222222"

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