/obj/item/clothing/hands/gloves/tutorial
	name = "right antimagic armwraps"
	rarity = RARITY_MYTHICAL
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	desc = "Commonly worn by lizard thots."
	desc_extended = "Generic glove."

	icon = 'icons/obj/items/clothing/gloves/tutorial_gloves.dmi'

	item_slot = SLOT_HAND_RIGHT

	defense_rating = list(
		MAGIC = 75,
		HEAT = 25,
		COLD = -25,
		DARK = 25
	)

	size = SIZE_0
	weight = WEIGHT_0

	value = 120

/obj/item/clothing/hands/gloves/tutorial/left
	name = "left antimagic glove"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT