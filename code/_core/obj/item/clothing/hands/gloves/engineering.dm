/obj/item/clothing/hands/gloves/engineering
	name = "right engineering rig glove"
	desc = "Spacewalk with theese."
	desc_extended = "Part of the engineering rigsuit. Don't lose them!"
	icon = 'icons/obj/item/clothing/gloves/engineering_rig_gloves.dmi'

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	armor = /armor/hardsuit/engineering

	protection_cold = list(
		BODY_HAND_RIGHT = 2
	)

	size = SIZE_1

	value = 230

	can_save = FALSE

/obj/item/clothing/hands/gloves/engineering/left
	name = "left engineering rig glove"
	desc = "Spacewalk with theese."
	desc_extended = "Part of the engineering rigsuit. Don't lose them!"

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 2
	)

	can_save = FALSE