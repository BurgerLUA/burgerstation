/obj/item/clothing/feet/shoes/workboot
	name = "right steel-toe workboot"
	desc = "Heavy load coming trough!"
	desc_extended = "A heavy-duty boot for a heavy-duty work enviroment. Protects your feet against falling tools."
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/workboots.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		ARCANE = -AP_AXE,
		COLD = AP_SWORD,
		PAIN = INFINITY
	)

	size = SIZE_2

	value = 120



/obj/item/clothing/feet/shoes/workboot/left
	name = "left steel-toe workboot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U