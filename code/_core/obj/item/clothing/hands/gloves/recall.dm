/obj/item/clothing/hands/gloves/recall
	name = "abductor recall glove"
	desc = "Watch me disappear!"
	desc_extended = "A highly advanced techical interface device. This is responsible for those damn aliens teleporting. Wish you knew how to use this."
	icon = 'icons/obj/item/clothing/gloves/recall.dmi'

	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	protection_cold = list(
		BODY_HAND_LEFT = 3
	)