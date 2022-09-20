/obj/item/clothing/feet/shoes/engineering
	name = "right engineering boot"
	desc = "Magboots not included."
	desc_extended = "Part of the engineering rigsuit. Don't lose them!"

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/engineering_rig_boots.dmi'

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	armor = /armor/hardsuit/engineering

	size = SIZE_2

	value = 300

	speed_bonus = -0.1

	item_slot_layer = 3

	can_save = FALSE

/obj/item/clothing/feet/shoes/engineering/left
	name = "left engineering boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

	can_save = FALSE
