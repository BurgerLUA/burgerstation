/obj/item/clothing/feet/shoes/workboot
	name = "right steel-toe workboot"
	desc = "Heavy load coming through!"
	desc_extended = "A heavy-duty boot for a heavy-duty work enviroment. Protects your feet against falling tools."
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/workboots.dmi'

	armor = /armor/leather/hard_boot

	size = SIZE_2

	value = 120



/obj/item/clothing/feet/shoes/workboot/left
	name = "left steel-toe workboot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
