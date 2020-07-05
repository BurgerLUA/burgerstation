/obj/item/clothing/hands/gloves/tutorial
	name = "right antimagic armwrap"
	rarity = RARITY_MYTHICAL
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	desc = "Data-mine the code with theese."
	desc_extended = "You probably shouldn't have this."

	icon = 'icons/obj/item/clothing/gloves/tutorial_gloves.dmi'

	item_slot = SLOT_HAND_RIGHT

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		MAGIC = 75,
		HEAT = 25,
		COLD = 25
	)

	size = SIZE_0
	weight = WEIGHT_0

	value = 120

/obj/item/clothing/hands/gloves/tutorial/left
	name = "left antimagic armwrap"
	desc = "Data-mine the code with theese."
	desc_extended = "You probably shouldn't have this."
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)
	blocks_clothing = SLOT_HAND_LEFT