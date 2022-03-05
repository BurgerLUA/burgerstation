/obj/item/clothing/hands/gloves/captain
	name = "right glove of the captain"
	desc = "Be a comdom with these."
	desc_extended = "Fancy one-of-a-kind glove, issued to the station Captain. Don't lose the other one!"
	icon = 'icons/obj/item/clothing/gloves/captain.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	armor = /armor/military/medium/captain_gloves

	protection_cold = list(
		BODY_HAND_RIGHT = 1
	)

	size = SIZE_1

	value = 800

	contraband = TRUE

/obj/item/clothing/hands/gloves/captain/left
	name = "left glove of the captain"
	desc = "Be a comdom with these."
	desc_extended = "Fancy one-of-a-kind glove, issued to the station Captain. Don't lose the other one!"

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 1
	)