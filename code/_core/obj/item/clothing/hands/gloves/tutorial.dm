/obj/item/clothing/hands/gloves/tutorial
	name = "right antimagic armwrap"
	rarity = RARITY_MYTHICAL
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	desc = "Data-mine the code with theese."
	desc_extended = "You probably shouldn't have this."

	icon = 'icons/obj/item/clothing/gloves/tutorial_gloves.dmi'

	defense_rating = list(
		ARCANE = 80
	)

	size = SIZE_0


	value = 120

/obj/item/clothing/hands/gloves/tutorial/left
	name = "left antimagic armwrap"
	desc = "Data-mine the code with theese."
	desc_extended = "You probably shouldn't have this."
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)