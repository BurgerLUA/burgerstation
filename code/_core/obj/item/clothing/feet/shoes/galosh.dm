/obj/item/clothing/feet/shoes/galosh
	name = "right galosh"
	desc = "For when you're tired of slipping."
	desc_extended = "A bright yellow janitor's galosh. Prevents slipping on liquids."

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/galosh.dmi'

	armor = /armor/leather/hard_boot

	size = SIZE_2


	value = 60

	speed_bonus = 0



/obj/item/clothing/feet/shoes/galosh/left
	name = "left galosh"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

