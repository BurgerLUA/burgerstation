/obj/item/clothing/hands/gloves/colored/gladiator
	name = "right gladiator gauntlet"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	desc = "Fight with these."
	desc_extended = "A generic gladiator glove. Hope that you have a matching pair."
	icon = 'icons/obj/items/clothing/gloves/gladiator.dmi'
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

/obj/item/clothing/hands/gloves/colored/gladiator/left
	name = "left gladiator gauntlet"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)


/obj/item/clothing/hands/gloves/colored/gladiator/gold
	color = COLOR_GOLD


/obj/item/clothing/hands/gloves/colored/gladiator/gold/left
	name = "left gladiator gauntlet"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	color = COLOR_GOLD