/obj/item/clothing/hands/gloves/tutorial
	name = "right tutorial glove"
	rarity = RARITY_MYTHICAL
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	desc = "Commonly worn by lizard thots."
	desc_extended = "Generic glove."

	icon = 'icons/obj/items/clothing/gloves/tutorial_gloves.dmi'

	item_slot = SLOT_HAND_RIGHT

	defense_rating = list(
		MAGIC = ARMOR_S,
		HEAT = ARMOR_C,
		COLD = -ARMOR_C,
		DARK = ARMOR_C
	)

	size = SIZE_0
	weight = WEIGHT_0

	value = 120

/obj/item/clothing/hands/gloves/tutorial/left
	name = "left tutorial glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT